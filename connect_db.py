import MySQLdb
import ConfigParser
import os
import time


FIELD_TYPE = {}
cur_table = None
# cur_dbobj = None
connection_retry_counter = 1


class ConnectDB:
    def __init__(self):
        self.cur_table = None
        config = ConfigParser.ConfigParser()
        config.read(os.path.join(os.getcwd(), 'config.cfg'))
        self.dbUser = config.get('Database', 'username')
        self.dbPass = config.get('Database', 'password') if config.get('Database', 'password') else os.getenv("DB_PSW")
        self.dbConnectAttempt = config.get('Database', 'connect_attempt')
        self.dbHost = config.get('Database', 'host')
        self.dbDB = config.get('Database', 'db_name')
        # self.cursor = self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)

        for attempt in range(eval(self.dbConnectAttempt)):
            # print 'connection attempts: ', attempt
            try:
                self.conn = MySQLdb.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB)
                self.cursor = self.conn.cursor()
            except MySQLdb.Error, e:
                print "MySQL Error %d: %s", e.args[0], e.args[1]
                self.conn.rollback()
                # time.sleep(5)
                # self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            finally:
                if self.conn:
                    break
        # return cursor

    # def connect(self, dbHost, dbUser, dbPass, dbDB, dbConnectAttempt):
    #     for attempt in range(eval(dbConnectAttempt)):
    #         # print 'connection attempts: ', attempt
    #         try:
    #             self.conn = MySQLdb.connect(dbHost, dbUser, dbPass, dbDB)
    #             cursor = self.conn.cursor()
    #         except MySQLdb.Error, e:
    #             print "MySQL Error %d: %s", e.args[0], e.args[1]
    #             self.conn.rollback()
    #             time.sleep(5)
    #             self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
    #         finally:
    #             if self.conn:
    #                 break
    #     return cursor

    def select(self, table, dictionary=None, fetch_mult = True):
        try:
            if dictionary == None and fetch_mult == True:
                query = "SELECT * FROM %s ;" % table
                print query
                self.cursor.execute(query)
                result = self.cursor.fetchall()
                return result
            # global cur_table

            self.cur_table = table
            # global cur_dbobj
            # cur_dbobj = db_obj

            # import pdb; pdb.set_trace()
            dict_fields = []
            dict_values = []
            for item in dictionary:
                dict_fields.append(item)
                dict_values.append(dictionary[item])
            query = "SELECT * FROM %s WHERE (%s);" % (table, self.dict_to_where(dictionary))
            print query
            self.cursor.execute(query)
            print 'Query: ', query
            if fetch_mult:
                result = self.cursor.fetchall()
            else:
                result = self.cursor.fetchone()
            return result
        except MySQLdb.Error:
            self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            return self.select(table, dictionary, fetch_mult)



    def dict_to_where(self, dictionary):
        """
        Convert dictionary to WHERE clause.
        """
        dict_fields = []
        dict_values = []
        dict_expressions = []
        dictionary = self.format_fields(dictionary)
        for item in dictionary.keys():
            dict_fields = item
            dict_values = (dictionary[item])
            # import pdb; pdb.set_trace()
            if dict_values is None or dict_values == '':
                dict_expressions.append('%s IS NULL' % dict_fields)
            else:
                dict_expressions.append("%s = %s" % (dict_fields, dict_values))
        return " AND ".join(dict_expressions)


    def format_fields(self, dictionary):    # add functionality to handle list on values
        if not FIELD_TYPE.get(self.cur_table, False):
            FIELD_TYPE[self.cur_table] = self.get_field_type()

        for item in dictionary.keys():
            if 'char' in FIELD_TYPE[self.cur_table][item.lower()] and dictionary[item]:
                dictionary[item] = "'" + str(dictionary[item]) + "'"
        return dictionary


    def get_field_type(self):
        try:
            query = "SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '%s'" % self.cur_table
            # import pdb; pdb.set_trace()
            self.cursor.execute(query)
            rows = self.cursor.fetchall()
            field_type = {}
            for row in rows:
                field_type[row[0].lower()] = row[1].lower()
            return field_type
        except MySQLdb.Error:
            self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            self.get_field_type()

    def insert(self, table, dictionary):
        # import pdb;  pdb.set_trace()
        try:
            dict_fields = []
            dict_values = []
            for item in dictionary:
                dict_fields.append(item)
                if dictionary[item] is None:
                    dict_values.append('Null')
                    continue
                dict_values.append(str(dictionary[item]))
            query = "INSERT INTO %s (%s) VALUES(%s);" % (table, ", ".join(dict_fields), ", ".join(dict_values))
            self.cursor.execute(query)
            result = self.cursor.fetchall()
            return result
        except MySQLdb.Error:
            print MySQLdb.Error
            self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            if not self.select(table, dictionary):
                self.insert(table, dictionary)

    def update(self, table, dictionary, dict_where):
        try:
            set_query_part = ''
            where_query_part = ''
            for key in dictionary.keys():
                set_query_part += "%s='%s', " % (str(key), dictionary[key])
            for key in dict_where.keys():
                where_query_part += "%s='%s' AND " % (str(key), dict_where[key])
            query = "UPDATE %s SET %s WHERE %s ;" % (table, set_query_part[:-2], where_query_part[:-4])
            self.cursor.execute(query)
            result = self.cursor.fetchall()
            return result
        except MySQLdb.Error:
            self.connect(self.dbHost, self.dbUser, self.dbPass, self.dbDB, self.dbConnectAttempt)
            self.update(table, dictionary, dict_where)

    def execute_query(self, query):
        # import pdb; pdb.set_trace()
        print query
        # try:
        # query = "INSERT INTO `shield`.`login` (`username`,`auth_token`,`login_source`,`email_id`) VALUES ('dunkdude17', 'facebook$1705864569429171',  'facebook', 'dunkdude17@gmail.com');"
        self.cursor.execute(query)
        self.conn.commit()
        result = self.cursor.fetchall()
        return result
        # except MySQLdb.Error:
        #     print 'Error'


# cursor.execute("SELECT VERSION()")
# cursor.execute("SELECT *  FROM chinook.customer limit 10")
# results = cursor.fetchall()


# obj= ConnectDB()
# print '...'
# print obj.select('employee', {'City':'Calgary', 'Title':['Sales Support Agent', 'Sales Manager']})
# print obj.select('employee', {'City':'Calgary', 'Title':'Sales Support Agent', 'Title':'Sales Manager'})