import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

/**
 * Hello Records
 */
public class HelloRecords {

    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // C(reate)
        // This initializes an arbitrary key-value pair and stores it in KVLite.
        // The key-value structure is /helloKey : $value
        String movieIdString = "92616", value = "a";
        Key name = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("name"));
        Key year = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("year"));
        Key rating = Key.createKey(Arrays.asList("movie", movieIdString), Arrays.asList("rating"));
        Value nameValue = Value.createValue("Dr. Strangelove".getBytes());
        Value yearValue = Value.createValue("1996".getBytes());
        Value ratingValue = Value.createValue("8.6".getBytes());

        store.put(name, nameValue);
        store.put(year, yearValue);
        store.put(rating, ratingValue);

        // R(ead)
        // This queries KVLite using the same key.
        // The result, a byte array, is converted into a string.
        /*
        String result = new String(store.get(name).getValue().getValue());
        System.out.println(name.toString() + " : " + result);
        String result2 = new String(store.get(year).getValue().getValue());
        System.out.println(year.toString() + " : " + result2);
        String result3 = new String(store.get(rating).getValue().getValue());
        System.out.println(rating.toString() + " : " + result3);
        */

        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", movieIdString));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }


        store.close();
    }

}
