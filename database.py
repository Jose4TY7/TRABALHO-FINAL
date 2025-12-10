# No terminal digite: pip install mysql-connector-python

import mysql.connector
from mysql.connector import Error

class DatabaseManager:
    def __init__(self):
        self.connection = None
    
    def connect(self):
        try:
            # Configure com suas credenciais
            self.connection = mysql.connector.connect(
                host='localhost',
                user='root',
                password='1234567809',
                database='testdb'
            )
            print('Conectado ao MySQL com sucesso!')
            return True
        except Error as e:
            print(f'Erro ao conectar: {e}')
            return False
    
    def create_table(self):
        try:
            cursor = self.connection.cursor()
            create_table_sql = """
                CREATE TABLE IF NOT EXISTS users (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    email VARCHAR(100) NOT NULL UNIQUE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            """
            cursor.execute(create_table_sql)
            print('Tabela users criada ou verificada com sucesso!')
        except Error as e:
            print(f'Erro ao criar tabela: {e}')
    
    def insert_user(self, name, email):
        try:
            cursor = self.connection.cursor()
            sql = "INSERT INTO users (name, email) VALUES (%s, %s)"
            cursor.execute(sql, (name, email))
            self.connection.commit()
            print(f'Usuario inserido com ID: {cursor.lastrowid}')
        except Error as e:
            print(f'Erro ao inserir usuario: {e}')
    
    def select_users(self):
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT * FROM users")
            rows = cursor.fetchall()
            
            print('\nLista de Usuarios:')
            print('----------------------------------------')
            for row in rows:
                print(f"ID: {row[0]} | Nome: {row[1]} | Email: {row[2]} | Criado: {row[3]}")
            print('----------------------------------------')
            print(f"Total: {len(rows)} usuarios\n")
        except Error as e:
            print(f'Erro ao buscar usuarios: {e}')
    
    def show_menu(self):
        print('\nMENU DO BANCO DE DADOS')
        print('1. Inserir usuario')
        print('2. Listar usuarios')
        print('3. Sair')
    
    def start(self):
        if not self.connect():
            return
        
        self.create_table()
        
        while True:
            self.show_menu()
            option = input('Escolha uma opcao: ')
            
            if option == '1':
                name = input('Nome: ')
                email = input('Email: ')
                self.insert_user(name, email)
            
            elif option == '2':
                self.select_users()
            
            elif option == '3':
                print('Saindo...')
                break
            
            else:
                print('Opcao invalida!')
        
        if self.connection:
            self.connection.close()

# Executar o programa
if __name__ == "__main__":
    db_manager = DatabaseManager()
    db_manager.start()