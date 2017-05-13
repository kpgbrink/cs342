import oracle.kv.*;

import java.sql.*;
import java.util.Arrays;

import static java.sql.JDBCType.NULL;

// movie: id, name, year, rank
// role: actorId, movieId, role
// id: firstName, lastName

/**
 * Created by kpb23 on 5/11/2017.
 */
public class LoadDB {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "kpb23", "bjarne");
        Statement jdbcStatement = jdbcConnection.createStatement();

        ResultSet studentResult = jdbcStatement.executeQuery("SELECT id, firstName, middleName, lastName, email FROM Student");

        // Load the students
        while (studentResult.next()) {

            String studentIdString = studentResult.getString(1);
            Key firstName = Key.createKey(Arrays.asList("student", studentIdString), Arrays.asList("firstName"));
            Key middleName = Key.createKey(Arrays.asList("student", studentIdString), Arrays.asList("middleName"));
            Key lastName = Key.createKey(Arrays.asList("student", studentIdString), Arrays.asList("lastName"));
            Key email = Key.createKey(Arrays.asList("student", studentIdString), Arrays.asList("email"));

            Value firstNameValue = Value.createValue(studentResult.getString(2).getBytes());
            Value middleNameValue = Value.createValue(studentResult.getString(3).getBytes());
            Value lastNameValue = Value.createValue(studentResult.getString(4).getBytes());
            Value emailValue = Value.createValue(studentResult.getString(5).getBytes());

            store.put(firstName, firstNameValue);
            store.put(middleName, middleNameValue);
            store.put(lastName, lastNameValue);
            store.put(email, emailValue);
        }
        studentResult.close();

        ResultSet scheduleResult = jdbcStatement.executeQuery("SELECT id, student_id, title, semester FROM Student");

        // Load the students
        while (scheduleResult.next()) {

            String studentIdString = studentResult.getString(1);
            Key firstName = Key.createKey(Arrays.asList("schedule", studentIdString), Arrays.asList("student_id"));
            Key middleName = Key.createKey(Arrays.asList("schedule", studentIdString), Arrays.asList("title"));
            Key lastName = Key.createKey(Arrays.asList("schedule", studentIdString), Arrays.asList("semester"));

            Value firstNameValue = Value.createValue(scheduleResult.getString(2).getBytes());
            Value middleNameValue = Value.createValue(scheduleResult.getString(3).getBytes());
            Value lastNameValue = Value.createValue(scheduleResult.getString(4).getBytes());

            store.put(firstName, firstNameValue);
            store.put(middleName, middleNameValue);
            store.put(lastName, lastNameValue);
        }
        scheduleResult.close();
        jdbcStatement.close();
        jdbcConnection.close();
    }
}
