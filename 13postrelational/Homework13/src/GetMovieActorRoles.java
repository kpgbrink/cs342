import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

// movie: id, name, year, rank
// role: actorId, movieId, role
// id: firstName, lastName

/**
 * Created by kpb23 on 5/12/2017.
 * Get the roles, if any, for which a given actor is cast in a give movie. Sample execution:
 */
public class GetMovieActorRoles {
    public static void main(String[] args) {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        // Using example keys
        System.out.println("Movie ID: 92616, Actor ID: 429719");
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616", "actor", "429719"));
        
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }
        
        store.close();
    }
}
