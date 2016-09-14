package extension.web;

import org.neo4j.kernel.configuration.Config;
import org.neo4j.server.web.WebServer;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;

@Path("/")
public class StaticWebResource {

    private File directory;

	public StaticWebResource(@Context Config configuration, @Context WebServer server) {

        String path = configuration.getParams().get("org.neo4j.server.guide.directory");
        if (path == null) path = "guides";
        File file = new File(path);
		this.directory = file.exists() ? file : null;

	}

    @Path("/")
    @Produces("text/html")
    @GET
    public Response index() throws IOException {
        return file("index.html"); // TODO html-file listing?
    }

    static Map<String,File> resources = new ConcurrentHashMap<>();

    @GET
    @Path("{file:(?i).+\\.(png|jpg|jpeg|svg|gif|html?|js|css|txt|grass)}")
    public Response file(@PathParam("file") String file) throws IOException {
        InputStream fileStream = findFileStream(file);
        if (fileStream == null) return Response.status(Response.Status.NOT_FOUND).build();
        else return Response.ok(fileStream, mediaType(file)).build();
    }

    private InputStream findFileStream(String fileName) throws IOException {
        File file = resources.computeIfAbsent(fileName, new Function<String, File>() {
            public File apply(String s) {
                return findFile(s);
            }
        });
        return file == null ? null : new FileInputStream(file);
    }

    private File findFile(@PathParam("file") String file) {
        File f = new File(directory, file);
        return f.exists() ? f : null;
    }

    public String mediaType(String file) {
        int dot = file.lastIndexOf(".");
        if (dot == -1) return MediaType.TEXT_PLAIN;
        String ext = file.substring(dot + 1).toLowerCase();
        switch (ext) {
            case "png":
                return "image/png";
            case "gif":
                return "image/gif";
            case "json":
                return MediaType.APPLICATION_JSON;
            case "js":
                return "text/javascript";
            case "css":
                return "text/css";
            case "svg":
                return MediaType.APPLICATION_SVG_XML;
            case "html":
                return MediaType.TEXT_HTML;
            case "txt":
                return MediaType.TEXT_PLAIN;
            case "jpg":
            case "jpeg":
                return "image/jpg";
            default:
                return MediaType.TEXT_PLAIN;
        }
    }
}
