package cc.mzou.demoservice.controllers

import cc.mzou.demoservice.interfaces.ServiceInterface
import cc.mzou.demoservice.services.GreetingService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression
import org.springframework.context.annotation.Bean
import org.springframework.stereotype.Controller
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestMethod
import org.springframework.web.bind.annotation.ResponseBody

@Controller
class GreetingController {
  @Bean
  @ConditionalOnExpression("#{'\${service.type}'=='simple'}")
  fun greetingService(): ServiceInterface = GreetingService()

  @Autowired
  lateinit var service: ServiceInterface

  @RequestMapping(value = ["/user/{name}"], method = [RequestMethod.GET])
  @ResponseBody
  fun greeting(@PathVariable name: String) = service.greeting(name)
}
