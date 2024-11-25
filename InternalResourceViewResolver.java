package com.giuggiola.config;

import org.springframework.context.annotation.Configuration;

@Configuration
public class InternalResourceViewResolver {
	
	//private String prefix="/webapp/WEB-INF/";
	private String prefix="/WEB-INF/";
	private String suffix=".jsp";
	
	public void setPrefix(String prefix) {
		this.prefix="";
	}
	
	public void setSuffix(String suffix) {
		this.suffix="";
	}

	public InternalResourceViewResolver(String prefix, String suffix) {
		super();
		this.prefix = prefix;
		this.suffix = suffix;
	}

	public String getPrefix() {
		return prefix;
	}

	public String getSuffix() {
		return suffix;
	}
	
	
}
