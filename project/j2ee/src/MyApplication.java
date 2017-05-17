
import javax.ws.rs.ApplicationPath;
import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;

/* MyApplication runs the restful webservice
 * @author: Kristofer Brink
 * Created by kpb23 on 5/12/2017.
 */
@ApplicationPath("/")
public class MyApplication extends Application {

    @Override
    public Set<Class<?>> getClasses() {
        HashSet h = new HashSet<Class<?>>();
        h.add(Schedule.class);
        return h;
    }
}