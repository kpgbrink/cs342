import javax.ws.rs.*;

// The Java class will be hosted at the URI path "/helloworld"
@Path("/hello")
public class Hello {
    // GET should return a simple response (e.g., “Getting...”).
    @Path("/api")
    @GET
    @Produces("text/plain")
    public String getRequest() {
        return "Getting...";
    }

    // PUT should receive an integer from the HTTP request and return it in the response (e.g., “Putting: x”, where x is the passed integer value).
    @Path("/api/{x}")
    @PUT
    @Produces("text/plain")
    public String putRequest(@PathParam("x") int x) {
        return "Putting: " + x;
    }

    // POST should receive a string from the HTTP request and return it in the response (e.g., “Posting: s”, where s is the passed string value).
    @Path("/api/{s}")
    @POST
    @Produces("text/plain")
    public String postRequest(@PathParam("s") String s) {
        return "Posting: " + s;
    }
}