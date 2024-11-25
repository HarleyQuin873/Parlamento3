package com.giuggiola;

import org.springframework.boot.SpringApplication;

//import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.context.annotation.Bean;
//import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
//import org.springframework.boot.autoconfigure.jdbc.DataSourceTransactionManagerAutoConfiguration;
//import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;
import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.view.InternalResourceViewResolver;


@SpringBootApplication
//@Configuration
@ComponentScan({"com.giuggiola.controller"})
/*
@EnableAutoConfiguration(
		exclude = {
		DataSourceAutoConfiguration.class,  DataSourceTransactionManagerAutoConfiguration.class,   HibernateJpaAutoConfiguration.class
		}
		)
	*/	
//@EnableAutoConfiguration
public class ParlamentoApplication{

	public static void main(String[] args) {
		
		SpringApplication.run(ParlamentoApplication.class, args);
	
	  
	}
	
	
	/*
	@Bean
	public InternalResourceViewResolver jspViewResolver() {
	  var jspViewResolver = new InternalResourceViewResolver();
	  jspViewResolver.setPrefix("/webapp/");
	  jspViewResolver.setSuffix(".jsp");
	  return jspViewResolver;
	}	
	*/
}

/*@EnableAutoConfiguration(exclude = {DataSourceAutoConfiguration.class, 
 * DataSourceTransactionManagerAutoConfiguration.class, 
 * HibernateJpaAutoConfiguration.class}) public class Application
 *  { public static void main(String[] args) 
 *  { SpringApplication.run(PayPalApplication.class, args); } } */
 