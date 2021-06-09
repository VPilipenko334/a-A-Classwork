require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class Users
    def self.find_by_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                users
            WHERE
                id = ?
        SQL
        Users.new(data[0])
    end

    def self.find_by_name(first,last)
        data = QuestionsDatabase.instance.execute(<<-SQL, first, last)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ? 
        SQL
        Users.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end
end

class Questions 
    def self.find_by_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                questions
            WHERE
                id = ?
        SQL
        Questions.new(data[0])
    end

    def self.find_by_title(q_title)
        data = QuestionsDatabase.instance.execute(<<-SQL, q_title)
            SELECT
                *
            FROM
                questions 
            WHERE
                title = ? 
        SQL
        Questions.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end


end 