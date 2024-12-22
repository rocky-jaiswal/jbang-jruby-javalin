///usr/bin/env jbang "$0" "$@" ; exit $?

//DEPS org.slf4j:slf4j-simple:2.0.16
//DEPS com.fasterxml.jackson.core:jackson-databind:2.17.2
//DEPS io.javalin:javalin:6.4.0
//DEPS org.jdbi:jdbi3-core:3.47.0
//DEPS org.jdbi:jdbi3-sqlite:3.47.0
//DEPS org.xerial:sqlite-jdbc:3.47.0.0

import static java.lang.System.*;

import java.io.IOException;

public class RunJRuby {

    public static void main(String... args) throws IOException, InterruptedException {
        out.println("executing jruby script ...");
        out.println("--------------------------");
        // out.println(getProperty("java.class.path"));

        var processBuilder = new ProcessBuilder();
        processBuilder.inheritIO();

        var environment = processBuilder.environment();
        environment.put("CLASSPATH", getProperty("java.class.path"));

        processBuilder.command("jruby", args[0]);
        var process = processBuilder.start();

        int exitCode = process.waitFor();

        out.println("--------------------------");
        out.println("Exit code - " + exitCode);
    }
}
