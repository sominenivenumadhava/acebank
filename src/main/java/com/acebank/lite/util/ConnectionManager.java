package com.acebank.lite.util;

import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Logger;

public final class ConnectionManager {

    private static volatile boolean isSchemaInitialized = false;
    static final Logger log = Logger.getLogger(ConnectionManager.class.getName());

    // Cached connection config
    private static String url;
    private static String user;
    private static String pass;
    private static boolean driverLoaded = false;

    private ConnectionManager() {
    }

    /**
     * Returns a NEW connection per call. Callers are responsible for closing it.
     * This is thread-safe because each thread gets its own connection.
     */
    public static Connection getConnection() throws SQLException {
        loadDriver();

        Connection conn = DriverManager.getConnection(url, user, pass);

        // Run schema init only once, using the first successful connection
        if (!isSchemaInitialized) {
            synchronized (ConnectionManager.class) {
                if (!isSchemaInitialized) {
                    String scriptPath = ConfigLoader.getProperty(ConfigKeys.DB_SCRIPT_PATH);
                    if (scriptPath != null) {
                        runInitScript(conn, scriptPath);
                    }
                    isSchemaInitialized = true;
                }
            }
        }

        return conn;
    }

    private static synchronized void loadDriver() throws SQLException {
        if (driverLoaded) return;
        try {
            url = ConfigLoader.getProperty(ConfigKeys.DB_URL);
            user = ConfigLoader.getProperty(ConfigKeys.DB_USER);
            pass = ConfigLoader.getProperty(ConfigKeys.DB_PWD);
            String driverName = ConfigLoader.getProperty(ConfigKeys.DB_MYSQL_DRIVER);
            Class.forName(driverName);
            driverLoaded = true;
            log.info("Database driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found: " + e.getMessage(), e);
        }
    }

    private static void runInitScript(Connection conn, String path) {
        String normalizedPath = path.startsWith("/") ? path : "/" + path;
        try (InputStream is = ConnectionManager.class.getResourceAsStream(normalizedPath)) {
            if (is == null) {
                log.warning("SQL init script not found at: " + normalizedPath);
                return;
            }
            ScriptRunner runner = new ScriptRunner(conn);
            runner.setLogWriter(null);
            runner.setStopOnError(false);
            runner.runScript(new BufferedReader(new InputStreamReader(is)));
            log.info("SQL Schema checked/initialized.");
        } catch (Exception e) {
            log.severe("SQL Init Error: " + e.getMessage());
        }
    }
}
