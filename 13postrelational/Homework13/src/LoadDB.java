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

        ResultSet movieResult = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");

        // Load the Movies for Get Table Values from the movie table
        while (movieResult.next()) {
            System.out.println(movieResult.getInt(1) + "\t" + movieResult.getString(2) + "\t"
                    + movieResult.getString(3) + "\t" + movieResult.getString(4));

            String movieIdString = movieResult.getString(1);
            Key name = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("name"));
            Key year = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("year"));
            Key rating = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("rating"));
            Value nameValue = Value.createValue(movieResult.getString(2).getBytes());
            Value yearValue = Value.createValue(movieResult.getString(3).getBytes());

            // Some ranks are null
            if (movieResult.getString(4) != null) {
                Value ratingValue = Value.createValue(movieResult.getString(4).getBytes());
                store.put(rating, ratingValue);
            }
            store.put(name, nameValue);
            store.put(year, yearValue);
        }

        ResultSet roleResult = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");

        // Get the Role table for the GetMovieActorRoles
        while (roleResult.next()) {
            System.out.println(roleResult.getInt(1) + "\t" + roleResult.getString(2) + "\t"
                    + roleResult.getString(3) + "\t" + roleResult.getString(4));

            String movieIdString = roleResult.getString(1);
            Key actorId = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("name"));
            Key movieId = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("year"));
            Key role = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("rating"));
            Value nameValue = Value.createValue(movieResult.getString(2).getBytes());
            Value yearValue = Value.createValue(movieResult.getString(3).getBytes());

            // Some ranks are null
            if (movieResult.getString(4) != null) {
                Value ratingValue = Value.createValue(movieResult.getString(4).getBytes());
                store.put(rating, ratingValue);
            }
            store.put(name, nameValue);
            store.put(year, yearValue);
        }




        movieResult.close();
        jdbcStatement.close();
        jdbcConnection.close();
    }
}
