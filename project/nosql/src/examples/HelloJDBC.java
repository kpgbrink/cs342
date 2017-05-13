import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * This program used JDBC to query all the movies from the IMDB Movies table.
 * Include ojdbc6.jar (from the J2EE library) in the system path to support the JDBC functions.
 *
 * @author kvlinden
 * @version Spring, 2015
 */
public class HelloJDBC {
	// 1521
	public static void main(String[] args) throws SQLException {
		Connection jdbcConnection = DriverManager.getConnection(
				"jdbc:oracle:thin:@localhost:1521:xe", "imdb", "bjarne");
		Statement jdbcStatement = jdbcConnection.createStatement();
		ResultSet resultSet = jdbcStatement.executeQuery("SELECT id, name, year FROM Movie");
		while (resultSet.next()) {
			System.out.println(resultSet.getInt(1) + "\t" + resultSet.getString(2) + "\t"
					+ resultSet.getString(3));
		}

		// GetTableValues - Get the basic field values from the Movie table. The output should look something like this.
		//ResultSet getTableValues = jdbcStatement.executeQuery("SELECT id, name, year, rating FROM Movie");

		// GetMovieActorRoles - Get the roles, if any, for which a given actor is cast in a give movie. Sample execution:

		// GetMovieActors - Get the actors if any, who are cast in a given movie. Sample execution:

		// GetSortedMovies - List all the movies in order of year. Sample output:

		resultSet.close();
		jdbcStatement.close();
		jdbcConnection.close();
	}

}