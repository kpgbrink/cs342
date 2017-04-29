import javax.ws.rs.DELETE;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 * Created by kpb23 on 4/29/2017.
 */
@Path("/{x}")
public class DeleteHandler {
    @DELETE
    @Produces("text/plain")
    public String getClichedMessage(@PathParam("x") int x) {
        return "Deleting: " + x;
    }
}
