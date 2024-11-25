package com.giuggiola.config;

//mport org.springframework.web.servlet.View;
//import org.springframework.boot.autoconfigure.web.servlet.WebMvcProperties.View;
//import javax.swing.text.View;
import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
//import org.springframework.context.annotation.PropertySource;
//import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
//import org.springframework.data.web.config.EnableSpringDataWebSupport;
//import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
//import org.springframework.web.servlet.config.annotation.EnableWebMvc;
//import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//import org.springframework.web.servlet.view.BeanNameViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
//import org.springframework.web.servlet.view.JstlView;
//import org.springframework.boot.autoconfigure.data.web.SpringDataWebAutoConfiguration;
/*
import org.springframework.context.annotation.Configuration;
import org.springframework.data.web.PageableHandlerMethodArgumentResolver;
import org.springframework.data.web.config.EnableSpringDataWebSupport;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
*/
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
//WebMvcConfigurationSupport


//WebMvcAutoConfigurationAdapter
//@EnableSpringDataWebSupport
//@EnableWebMvc
//@PropertySource("classpath:application.properties")
//@EnableJpaRepositories("com.giuggiola.repository")


/*---------------------------------------------*/

//@Configuration
//@ComponentScan("com.giuggiola.controller")
//public class WebConfig implements WebMvcConfigurer{ //WebMvcAutoConfigurationAdapter{//WebMvcConfigurer {//WebMvcAutoConfiguration{
	
	
	/*-----------------------------------------------------*/
	
//WebMvcConfigurer { //public class WebConfig implements WebMvcConfigurer {
    // All web   configuration will go here
	
	// /Parlamento/src/main/webapp



/*---------------------------------------------*/
	//   private static final String[] CLASSPATH_RESOURCE_LOCATIONS = {"classpath:/webapp/" };   // {"classpath:/webapp/" };
	   /*---------------------------------------------*/	
	   
	   
	   
	   
	   
	 /*   private static final String[] CLASSPATH_RESOURCE_LOCATIONS = {
	            "classpath:/META-INF/resources/", "classpath:/resources/",
	            "classpath:/static/", "classpath:/public/","classpath:/webapp/", "classpath:/webapp/" };
*/
	   
	   
	   /*---------------------------------------------*/
	   /*
	    @Override
	    public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    //    registry.addResourceHandler("/**")
	     //       .addResourceLocations(CLASSPATH_RESOURCE_LOCATIONS);
	    }
	*/
	    /*---------------------------------------------*/
@Configuration
@EnableWebMvc
@ComponentScan("com.giuggiola.controller")
public class WebConfig {

  @Bean
  public InternalResourceViewResolver jspViewResolver() {
    var jspViewResolver = new InternalResourceViewResolver();
    jspViewResolver.setPrefix("/WEB-INF/");
    // jspViewResolver.setPrefix("/webapp/WEB-INF/");
    jspViewResolver.setSuffix(".jsp");
    return jspViewResolver;
  }
}
	 
	
/*---------------------------------------------*/
	/*
	@Bean
	public ViewResolver internalResourceViewResolver() {
	    InternalResourceViewResolver bean = new InternalResourceViewResolver();
	    bean.setViewClass(JstlView.class);
	    bean.setPrefix("/webapp/");
	    bean.setSuffix(".jsp");
	    return bean;
	}
	
	@Bean
	public BeanNameViewResolver beanNameViewResolver(){
	    return new BeanNameViewResolver();
	}
	
	@Bean
	public View cerca_parlamentare_dalla_circoscrizione() { //JstlView
	    return  new JstlView("/cerca_parlamentare_dalla_circoscrizione.jsp");
	}
	
	@Bean
	public View lista_parlamentari_circoscrizione() { //JstlView
	    return  new JstlView("/lista_parlamentari_circoscrizione.jsp");
	}
	
	
	
}
*/
/*---------------------------------------------*/

  //@EnableWebMvc
 /*
//@ComponentScan(basePackages = { "com.baeldung.web.controller" })
@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(final ViewControllerRegistry registry) {
        registry.addViewController("/")
            .setViewName("index");
    }

   
    @Bean
    public CommonsMultipartResolver multipartResolver() throws IOException {
        CommonsMultipartResolver resolver = new CommonsMultipartResolver();
        resolver.setMaxUploadSize(10000000);
        return resolver;
    }

    @Bean
    public ViewResolver viewResolver() {
        final InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/view/");
        bean.setSuffix(".jsp");
        bean.setOrder(2);
        return bean;
    }

    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**")
            .addResourceLocations("/", "/resources/")
            .setCachePeriod(3600)
            .resourceChain(true)
            .addResolver(new PathResourceResolver());
    }

   
    @Bean
    public ResourceBundleThemeSource themeSource() {
        ResourceBundleThemeSource themeSource = new ResourceBundleThemeSource();
        themeSource.setDefaultEncoding("UTF-8");
        themeSource.setBasenamePrefix("themes.");
        return themeSource;
    }

    @Bean
    public CookieThemeResolver themeResolver() {
        CookieThemeResolver resolver = new CookieThemeResolver();
        resolver.setDefaultThemeName("default");
        resolver.setCookieName("example-theme-cookie");
        return resolver;
    }

    @Bean
    public ThemeChangeInterceptor themeChangeInterceptor() {
        ThemeChangeInterceptor interceptor = new ThemeChangeInterceptor();
        interceptor.setParamName("theme");
        return interceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(themeChangeInterceptor());
    }

    

    @Bean
    public BeanNameViewResolver beanNameViewResolver(){
        BeanNameViewResolver beanNameViewResolver = new BeanNameViewResolver();
        beanNameViewResolver.setOrder(1);
        return beanNameViewResolver;
    }

    @Bean
    public View sample() {
        return new JstlView("/WEB-INF/view/sample.jsp");
    }

    @Bean
    public View sample2() {
        return new JstlView("/WEB-INF/view2/sample2.jsp");
    }

    @Bean
    public View sample3(){
        return new JstlView("/WEB-INF/view3/sample3.jsp");
    }

    
    @Override
    public void configureContentNegotiation(final ContentNegotiationConfigurer configurer) {
        configurer.favorParameter(true)
            .parameterName("mediaType")
            .ignoreAcceptHeader(false)
            .useRegisteredExtensionsOnly(false)
            .defaultContentType(MediaType.APPLICATION_JSON)
            .mediaType("xml", MediaType.APPLICATION_XML)
            .mediaType("json", MediaType.APPLICATION_JSON);
    }
}
*/