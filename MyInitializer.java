package com.giuggiola.config;

import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class MyInitializer extends AbstractAnnotationConfigDispatcherServletInitializer {

	  protected Class<?>[] getRootConfigClasses() {
	    return null;
	  }

	  protected Class<?>[] getServletConfigClasses() {
	    return new Class[] { WebConfig.class};
	  }
	  
	 
	  @Override
	  protected String[] getServletMappings() {
	    return new String[]{"/"};
	    //return new String[]{"/webapp/*"};
	  }
	}

