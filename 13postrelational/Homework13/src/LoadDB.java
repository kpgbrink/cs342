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
                "jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
        Statement jdbcStatement = jdbcConnection.createStatement();

        ResultSet movieResult = jdbcStatement.executeQuery("SELECT id, name, year, rank FROM Movie");

        // Load the Movies for Get Table Values from the movie table
        // Movies are created with id, name, year, and rank in order to have all the information needed
        // for queries.
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
            } else {
                store.put(rating, "");
            }
            store.put(name, nameValue);
            store.put(year, yearValue);
        }
        movieResult.close();

        ResultSet roleResult = jdbcStatement.executeQuery("SELECT actorId, movieId, role FROM role");

        // Get the Role table for the GetMovieActorRoles
        // Use both actor and movie ids for the keys.
        while (roleResult.next()) {
            String roleIdString = roleResult.getString(1) + " " + roleResult.getString(2);
            Key actor = Key.createKey(Arrays.asList("role", roleIdString), Arrays.asList("actorId"));
            Key movie = Key.createKey(Arrays.asList("role", roleIdString), Arrays.asList("movieId"));
            Key role = Key.createKey(Arrays.asList("role", roleIdString), Arrays.asList("role"));
            
            Value actorValue = Value.createValue(movieResult.getString(1).getBytes());
            Value movieValue = Value.createValue(movieResult.getString(2).getBytes());
            
            
            // role could be null
            if (roleResult.getString(3) != null) {
                Value roleValue = Value.createValue(roleResult.getString(3).getBytes());
                store.put(role, roleValue);
            } else {
                store.put(role, "");
            }
            store.put(actor, actorValue);
            store.put(movie, movieValue);
        }
        roleSet.close();
        
        // Get the actors
        ResultSet actorResult = jdbcStatement.executeQuery("SELECT id, firstName, lastName FROM Actor");

        // Load the Movies for Get Table Values from the movie table
        // Movies are created with id, name, year, and rank in order to have all the information needed
        // for queries.
        while (actorResult.next()) {

            String actorIdString = actorResult.getString(1);
            Key firstName = Key.createKey(Arrays.asList("actor", actorIdString), Arrays.asList("firstName"));
            Key lastName = Key.createKey(Arrays.asList("actor", actorIdString), Arrays.asList("lastName"));
            
            // Just in case if firstName is null
            if (actorResult.getString(3) != null) {
                Value firstNameValue = Value.createValue(actorResult.getString(3).getBytes());
                store.put(firstName, firstNameValue);
            } else {
                store.put(firstName, "");
            }
            // Just in case if lastName is null
            if (actorResult.getString(3) != null) {
                Value lastNameValue = Value.createValue(actorResult.getString(3).getBytes());
                store.put(lastName, lastNameValue);
            } else {
                store.put(firstName, "");
            }
            
        }
        actorResult.close();


        jdbcStatement.close();
        jdbcConnection.close();
    }
}
