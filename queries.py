from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

DATABASE_URL = 'postgresql://postgres.sxpogvfobwpcysjeswzm:61xEfbIhsYqsw1g3@aws-0-eu-central-1.pooler.supabase.com:5432/postgres'

engine = create_engine(DATABASE_URL)
Session = sessionmaker(bind=engine)


with Session() as session:
    query = text("SELECT * FROM Disease WHERE pathogen='bacteria'")
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    query = text("""
    SELECT u.first_name, d.degree
    FROM Doctor d
    JOIN Users u ON u.email = d.email
    WHERE d.email NOT IN (
        SELECT s.email
        FROM Specialize s
        JOIN DiseaseType dt ON s.disease_id = dt.id
        WHERE dt.description = 'infectious diseases'
    );
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    query = text("""
    SELECT u.first_name, u.surname, d.degree
    FROM Doctor d
    JOIN Users u ON u.email = d.email
    JOIN Specialize s ON s.email = d.email
    GROUP BY u.first_name, u.surname, d.email
    HAVING COUNT(s.disease_id) > 2;
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    query = text("""
    SELECT u.cname AS country, AVG(u.salary) AS average_salary
    FROM Users u
    JOIN Doctor d ON u.email=d.email
    JOIN Specialize s ON d.email=s.email
    JOIN DiseaseType dt ON s.disease_id=dt.id
    WHERE dt.description='virology'
    GROUP BY u.cname;
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    query = text("""
    SELECT ps.department, COUNT(DISTINCT ps.email) AS employee_num 
    FROM PublicServant as ps 
    JOIN Record r ON r.email=ps.email
    JOIN Disease d ON d.disease_code=r.disease_code
    WHERE d.description='covid-19'
    GROUP BY ps.department
    HAVING COUNT(DISTINCT r.cname) > 1;
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    try: #dml should is treated as transaction, so we explicitly commit it, and in case of error we rollback
        query = text("""
        UPDATE Users u
        SET salary = salary*2
        WHERE u.email IN (
        SELECT r.email
        FROM Record r
        JOIN Disease d ON d.disease_code=r.disease_code
        WHERE d.description='covid-19'
        GROUP BY r.email, r.total_patients
        HAVING r.total_patients>=3
        );
        """)
        session.execute(query)
        session.commit()  
    except Exception as e:
        session.rollback()
        print(f"Error: {e}")

with Session() as session:
    try:
        query = text("""
        DELETE FROM Users
        WHERE first_name ILIKE '%bek%' OR first_name ILIKE '%gul%';
        """)
        session.execute(query)
        session.commit()  
    except Exception as e:
        session.rollback()
        print(f"Error: {e}")


with Session() as session:
    try:
        query = text("CREATE INDEX idx_email_users ON Users (email)")
        session.execute(query)

        query = text("CREATE INDEX idx_disease_code ON Disease (disease_code)")
        session.execute(query)
        session.commit()  
    except Exception as e:
        session.rollback()
        print(f"Error: {e}")


with Session() as session:
    query = text("""
    SELECT r.cname, SUM(r.total_patients) AS patients_num
    FROM Record r
    GROUP BY r.cname
    ORDER BY patients_num DESC
    LIMIT 2;
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    query = text("""
    SELECT SUM(r.total_patients) AS patients_num
    FROM Record r
    JOIN Disease d ON d.disease_code=r.disease_code
    WHERE d.description='covid-19';
    """)
    result = session.execute(query)
    for row in result:
        print(row)


with Session() as session:
    try:
        query = text("""
        CREATE VIEW PatientDiseaseView AS
        SELECT u.first_name, u.surname, d.description AS disease_description
        FROM Users u
        JOIN Patients p ON p.email = u.email
        JOIN PatientDisease pd ON pd.email = p.email
        JOIN Disease d ON d.disease_code = pd.disease_code;
        """)
        session.execute(query)
        session.commit() 
    except Exception as e:
        session.rollback()
        print(f"Error creating view: {e}")


with Session() as session:
    try:
        query = text('SELECT * FROM PatientDiseaseView;')
        result = session.execute(query)
        for row in result:
            print(row)
    except Exception as e:
        print(f"Error querying view: {e}")
