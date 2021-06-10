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
    attr_reader :fname, :lname 
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

    def authored_questions
        Questions.find_by_author_id(@id)
    end

    def authored_replies
        Replies.find_by_user_id(@id)
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
        result = []
        data.each { |datum| result << Questions.new(datum) }
        result
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
        result = []
        data.each { |datum| result << Questions.new(datum) }
        result
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
        result = []
        data.each { |datum| result << Questions.new(datum) }
        result
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @user_id = options['user_id']
    end

    def author 
        data = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
        SELECT 
            *
        FROM 
            users
        WHERE
            id = ?
        SQL
        first = data[0]['fname'] #data --> an array of hashes where each hash is a row in our table 
        last = data[0]['lname']
        first + " " + last 
    end

    def replies
        Replies.find_by_question_id(@id)
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
    
    def self.followers_for_question_id(question_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
            fname, lname
        FROM
            users
        JOIN  
            question_follows ON users.id = question_follows.user_id
        JOIN 
            questions ON questions.id = question_follows.question_id 
        WHERE
            question_id = ? 
        SQL
        users = []
        data.each {|datum| users << datum['fname'] + " " + datum['lname']}
        users 
    end

    def self.followed_questions_for_user_id(user_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            title, body
        FROM
            question_follows
        JOIN
            questions ON question_follows.question_id = questions.id
        WHERE
            question_follows.user_id = ? 
        SQL
        
        questions = []
        data.each {|datum| questions << "#{datum['title']}: #{datum['body']}"}
        questions
    end

    def self.find_by_id(question_follows_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, question_follows_id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        result = []
        data.each { |datum| result << QuestionFollows.new(datum) }
        result
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
        result = []
        data.each { |datum| result << QuestionFollows.new(datum) }
        result
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
        result = []
        data.each { |datum| result << QuestionFollows.new(datum) }
        result
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
        result = []
        data.each { |datum| result << QuestionLikes.new(datum) }
        result
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
        result = []
        data.each { |datum| result << QuestionLikes.new(datum) }
        result
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
        result = []
        data.each { |datum| result << Replies.new(datum) }
        result
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
        result = []
        data.each { |datum| result << Replies.new(datum) }
        result
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

    def self.find_by_parent(parent_id)
        data = QuestionsDatabase.instance.execute(<<-SQL, parent_id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent = ?
        SQL
        result = []
        data.each { |datum| result << Replies.new(datum) }
        result
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
        result = []
        data.each { |datum| result << Replies.new(datum) }
        result
    end

    def initialize(options)
        @id = options['id']
        @user_id = options['user_id']
        @question_id = options['question_id']
        @parent = options['parent']
        @body = options['body']
    end

    def author
        data = QuestionsDatabase.instance.execute(<<-SQL, @user_id)
        SELECT 
            *
        FROM 
            users
        WHERE
            id = ?
        SQL

        first = data[0]['fname'] #data --> an array of hashes where each hash is a row in our table 
        last = data[0]['lname']
        first + " " + last 
    end

    def question
        data = QuestionsDatabase.instance.execute(<<-SQL, @question_id)
        SELECT 
            *
        FROM 
            questions
        WHERE
            id = ?
        SQL

        result = Questions.new(data[0])
    end

    def parent_reply
        data = QuestionsDatabase.instance.execute(<<-SQL, @parent)
        SELECT 
            *
        FROM 
            replies
        WHERE
            id = ?
        SQL

        result = Replies.new(data[0])
    end

    def child_replies
        
        data = QuestionsDatabase.instance.execute(<<-SQL, @id)
        SELECT 
            *
        FROM 
            replies
        WHERE
            parent = ?
        SQL

        raise ArgumentError.new '#{self} does not have a parent' if data.empty?
        result = Replies.new(data[0])
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