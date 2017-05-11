import oracle.kv.*;

import java.sql.*;
import java.util.Arrays;

import static java.sql.JDBCType.NULL;

/**
 * Created by kpb23 on 5/11/2017.
 */
public class LoadDB {
    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        Connection jdbcConnection = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        Statement jdbcStatement = jdbcConnection.createStatement();

        ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");

        // Load the Movies for Get Table Values from the movie table
        while (resultSet.next()) {
            System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t"
                    + resultSet.getString(3) + "\t" + resultSet.getString(4));

            String movieIdString = resultSet.getString(1);
            Key name = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("name"));
            Key year = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("year"));
            Key rating = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("rating"));
            Value nameValue = Value.createValue(resultSet.getString(2).getBytes());
            Value yearValue = Value.createValue(resultSet.getString(3).getBytes());

            // Some ranks are null
            if (resultSet.getString(4) != null) {
                Value ratingValue = Value.createValue(resultSet.getString(4).getBytes());
                store.put(rating, ratingValue);
            }
            store.put(name, nameValue);
            store.put(year, yearValue);
        }




        resultSet.close();
        jdbcStatement.close();
        jdbcConnection.close();
    }
}
