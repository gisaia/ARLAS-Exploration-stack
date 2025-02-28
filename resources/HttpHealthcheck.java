import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpHealthcheck {

    public static void main(String[] args) {
        try {
            if (args.length == 1 && isURLAvailable(args[0])) {
                System.exit(0);
            }
        } catch (Exception e) { }
        System.exit(1);
    }

    private static boolean isURLAvailable(String urlString) throws IOException {
        HttpURLConnection connection = (HttpURLConnection) new URL(urlString).openConnection();
        connection.setRequestMethod("GET");
        connection.setConnectTimeout(5000);

        int responseCode = connection.getResponseCode();
        return (responseCode >= 200 && responseCode < 300);
    }
}