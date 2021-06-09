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

    def create
        QuestionsDatabase.instance.execute(<<-SQL, @id, @fname, @lname)
        INSERT INTO 
            users(id, fname, lname)
        VALUES
            (?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id 
    end
end

class Questions
    def self.find_by_author_id(author_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                user_id = ?
        SQL
        Questions.new(data[0])
    end
    
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

    def create
        QuestionsDatabase.instance.execute(<<-SQL, @id, @title, @body, @user_id)
        INSERT INTO 
            questions (id, title, body, user_id)
        VALUES
            (?,?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id 
    end
end

class QuestionFollows
    def self.find_by_id(question_follows_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_follows_id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        QuestionFollows.new(data[0])
    end

    def self.find_by_user_id(u_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, u_id)
            SELECT
                *
            FROM
                question_follows 
            WHERE
                user_id = ? 
        SQL
        QuestionFollows.new(data[0])
    end

    def self.find_by_question_id(q_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, q_id)
            SELECT
                *
            FROM
                question_follows 
            WHERE
                question_id = ? 
        SQL
        QuestionFollows.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def create
        QuestionsDatabase.instance.execute(<<-SQL, @id, @user_id, @question_id)
        INSERT INTO 
            question_follows (id, user_id, question_id)
        VALUES
            (?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id 
    end
end

class QuestionLikes
    def self.find_by_user_id(u_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, u_id)
            SELECT
                *
            FROM
                question_likes 
            WHERE
                user_id = ? 
        SQL
        QuestionLikes.new(data[0])
    end

    def self.find_by_question_id(q_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, q_id)
            SELECT
                *
            FROM
                question_likes 
            WHERE
                question_id = ? 
        SQL
        QuestionLikes.new(data[0])
    end

    def initialize(options)
        @user_id = options['user_id']
        @question_id = options['question_id']
    end

    def create
        QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
        INSERT INTO 
            question_likes (user_id, question_id)
        VALUES
            (?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id 
    end
end

class Replies
    def self.find_by_id(reply_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, reply_id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        Replies.new(data[0])
    end

    def self.find_by_user_id(u_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, u_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ? 
        SQL
        Replies.new(data[0])
    end

    def self.find_by_question_id(q_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, q_id)
            SELECT
                *
            FROM
                replies 
            WHERE
                question_id = ? 
        SQL
        
        result = []
        data.each { |datum| result << Replies.new(datum) }
        result
    end

    def self.find_by_id(parent_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent = ?
        SQL
        Replies.new(data[0])
    end

    def self.find_by_body(rbody)
        data = QuestionsDatabase.instance.execute(<<-SQL, rbody)
            SELECT
                *
            FROM
                replies
            WHERE
                body = ?
        SQL
        Replies.new(data[0])
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent = options['parent']
        @body = options['body']
    end

    def create
        QuestionsDatabase.instance.execute(<<-SQL, @id, @user_id, @question_id, @parent, @body)
        INSERT INTO 
            replies (id, user_id, question_id, parent, body)
        VALUES
            (?,?,?,?,?)
        SQL
        @id = QuestionsDatabase.instance.last_insert_row_id 
    end
end