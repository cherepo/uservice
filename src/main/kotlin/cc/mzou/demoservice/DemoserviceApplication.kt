package cc.mzou.demoservice

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DemoserviceApplication

fun main(args: Array<String>) {
	runApplication<DemoserviceApplication>(*args)
}
