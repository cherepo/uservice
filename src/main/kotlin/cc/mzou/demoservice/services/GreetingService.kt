package cc.mzou.demoservice.services

import cc.mzou.demoservice.interfaces.ServiceInterface
import org.springframework.beans.factory.annotation.Value

class GreetingService: ServiceInterface {
  @Value(value = "\${service.message.text}")
  private lateinit var text: String

  override fun greeting(name: String) = "$text $name"
}
