package com.example.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;

import javax.annotation.PostConstruct;
import javax.sql.DataSource;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@Configuration
public class DatabaseInitializer {

    @Autowired
    private DataSource dataSource;

    @PostConstruct
    public void init() {
        try {
            Connection connection = dataSource.getConnection();
            try {
                if (!tableExists(connection, "books")) {
                    executeSqlScript(connection, "/schema.sql");
                }
                if (!dataExists(connection, "books")) {
                    executeSqlScript(connection, "/data.sql");
                }
            } finally {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private boolean tableExists(Connection connection, String tableName) throws SQLException {
        try {
            Statement stmt = connection.createStatement();
            try {
                stmt.executeQuery("SELECT 1 FROM " + tableName + " LIMIT 1");
                return true;
            } catch (SQLException e) {
                return false;
            } finally {
                stmt.close();
            }
        } catch (SQLException e) {
            return false;
        }
    }

    private boolean dataExists(Connection connection, String tableName) throws SQLException {
        Statement stmt = connection.createStatement();
        try {
            var result = stmt.executeQuery("SELECT COUNT(*) FROM " + tableName);
            if (result.next()) {
                return result.getInt(1) > 0;
            }
            return false;
        } finally {
            stmt.close();
        }
    }

    private void executeSqlScript(Connection connection, String resourcePath) {
        try {
            ClassPathResource resource = new ClassPathResource(resourcePath);
            if (resource.exists()) {
                InputStream is = resource.getInputStream();
                BufferedReader reader = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                StringBuilder sqlBuilder = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    sqlBuilder.append(line).append("\n");
                }
                reader.close();

                String[] sqlStatements = sqlBuilder.toString().split(";");
                Statement stmt = connection.createStatement();
                for (String sql : sqlStatements) {
                    sql = sql.trim();
                    if (!sql.isEmpty() && !sql.startsWith("--")) {
                        stmt.execute(sql);
                    }
                }
                stmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}