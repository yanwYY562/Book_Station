package com.example.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
@PropertySource(value = "classpath:application.properties", ignoreResourceNotFound = true)
public class AppConfig {

    @Value("${db.driver:com.mysql.cj.jdbc.Driver}")
    private String driver;

    @Value("${db.url:}")
    private String dbUrl;

    @Value("${db.username:}")
    private String dbUsername;

    @Value("${db.password:}")
    private String dbPassword;

    @Value("${MYSQL_URL:}")
    private String mysqlUrl;

    @Value("${MYSQLUSERNAME:}")
    private String mysqlUsername;

    @Value("${MYSQLPASSWORD:}")
    private String mysqlPassword;

    @Value("${MYSQLDATABASE:book_store}")
    private String mysqlDatabase;

    @Value("${DB_HOST:localhost}")
    private String dbHost;

    @Value("${DB_PORT:3306}")
    private String dbPort;

    @Value("${DB_NAME:book_store}")
    private String dbName;

    @Value("${DB_USER:root}")
    private String dbUser;

    @Value("${DB_PASSWORD:123456}")
    private String dbPass;

    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(driver);
        
        String url = buildJdbcUrl();
        String username = getUsername();
        String password = getPassword();
        
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        return dataSource;
    }

    private String buildJdbcUrl() {
        if (mysqlUrl != null && !mysqlUrl.isEmpty()) {
            String jdbcUrl = mysqlUrl.replace("mysql://", "jdbc:mysql://");
            if (!jdbcUrl.contains("?")) {
                jdbcUrl += "?";
            }
            if (!jdbcUrl.contains("useSSL")) {
                jdbcUrl += "&useSSL=false";
            }
            if (!jdbcUrl.contains("serverTimezone")) {
                jdbcUrl += "&serverTimezone=UTC";
            }
            if (!jdbcUrl.contains("allowPublicKeyRetrieval")) {
                jdbcUrl += "&allowPublicKeyRetrieval=true";
            }
            return jdbcUrl;
        }
        if (dbUrl != null && !dbUrl.isEmpty()) {
            return dbUrl;
        }
        return "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    }

    private String getUsername() {
        if (mysqlUsername != null && !mysqlUsername.isEmpty()) {
            return mysqlUsername;
        }
        if (dbUsername != null && !dbUsername.isEmpty()) {
            return dbUsername;
        }
        return dbUser;
    }

    private String getPassword() {
        if (mysqlPassword != null && !mysqlPassword.isEmpty()) {
            return mysqlPassword;
        }
        if (dbPassword != null && !dbPassword.isEmpty()) {
            return dbPassword;
        }
        return dbPass;
    }

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
}