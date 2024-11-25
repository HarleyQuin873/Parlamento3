package com.giuggiola.controller;

//import java.util.ArrayList;
//import android.view.Window;
//import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.ModelAttribute;
//import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
//import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
//import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import com.giuggiola.entity.PK;
import com.giuggiola.entity.Parlamentare;
import com.giuggiola.entity.Periodi_cariche;
import com.giuggiola.repository.ParlamentareRepository;
import com.giuggiola.repository.RangeRepository;
//import org.json.simple.JSONObject;
//@RestController

//@EnableWebMvcSecurity
//@EnableWebMvc
@RestController
@ComponentScan({"com.giuggiola.controller"})
public class ParlamentareController{


	@Autowired
	 ParlamentareRepository parlamRepo;	
	
	@Autowired
	 RangeRepository periodiRepo;
	
	/*
	@GetMapping("/sample")
	public String showForm() {
	    return "sample";
	}
	*/
	 
	
	
	 @RequestMapping("/Parlamento")
	 public ModelAndView index() {
		 
		 ModelAndView mv= new ModelAndView();
		 mv.setViewName("index.jsp");
			return mv;
	 }
	 
	 
	@RequestMapping("/parlamentari")
	public ModelAndView home(Parlamentare parlamentare) 
	{	
		ModelAndView mv= new ModelAndView();
	
		//List<Parlamentare> parlamentari =parlamRepo.findAll();
		//mv.addObject("parlamentari",parlamentari);
		mv.setViewName("parlamentari.jsp");
		return mv;
	}
	
	
	@RequestMapping("/lista_parlamentari")
	@ResponseBody
	public ModelAndView getParlamentari() 
	{	
		ModelAndView mv= new ModelAndView();
	
		List<Parlamentare> parlamentari =parlamRepo.findAll();
		mv.addObject("parlamentari",parlamentari);
		mv.setViewName("lista_parlamentari.jsp");
		return mv;
	}
	
	
	
	@RequestMapping("/aggiungi_parlamentare")
	@ResponseBody
	public ModelAndView addParlamentare(Parlamentare parlamentare)
	{
		ModelAndView mv = new ModelAndView();
		parlamRepo.save(parlamentare);
		mv.addObject("parlamentare",parlamentare);
		mv.setViewName("showParlamentare4.jsp");
		return mv;//"home.jsp";	
	}	
	
	/*
	@RequestMapping(value="/getParlamentare")//, method = RequestMethod.POST)
	public @ResponseBody ModelAndView getParlamentare(@RequestParam("nome") String nome, 
			@RequestParam("partito") String partito,
			@RequestParam("circoscrizione") String[] circoscrizione)
	{
		ModelAndView mv = new ModelAndView();
		Parlamentare parlamentare = parlamRepo.findByPkk(nome,partito,circoscrizione);//.orElse(new Parlamentare());
		mv.setViewName("showParlamentare.jsp");
		//mv.
		mv.addObject(parlamentare);
		//parlamRepo. save(parlamentare);
		return mv;
		//return "redirect:/showParlamentare";	
	}	
	*/
	
	@RequestMapping("/cerca_parlamentare_dal_partito")
	public ModelAndView getParlamentare3(@RequestParam String partito)
	{
		ModelAndView mv = new ModelAndView();
		List<Parlamentare> parlamentari = parlamRepo.findByPartito(partito);
		System.out.println(parlamRepo.findByPartito(partito));
		mv.addObject(parlamentari);
		mv.setViewName("lista_parlamentari_partito.jsp");
		return mv;	
	}
	/*
	public String[] create(@RequestBody JSONObject requestParams) {
	      String[] circoscrizioni=requestParams.get((String[])"circoscrizioni");
	      List<Parlamentare> circoscrizioni2=requestParams.getJSONArray("circoscrizioni").toJavaList(Parlamentare.class);
	}*/
	
	
	@GetMapping("/cerca_parlamentare_dalla_circoscrizione")
	//@RequestMapping("/cerca_parlamentare_dalla_circoscrizione")
	public String getParlamentare4(@RequestParam("circoscrizione") String circoscrizionee)
	{//	public ModelAndView getParlamentare4(@RequestParam("circoscrizione") String circoscrizionee)
		ModelAndView mv = new ModelAndView();
		List<Parlamentare> parlamentari = parlamRepo.findByCircoscrizione(circoscrizionee);
		mv.addObject(parlamentari);
		mv.setViewName("lista_parlamentari_circoscrizione.jsp");
		//return mv;	
		return "lista_parlamentari_circoscrizione.jsp";
	}
	
	/*@GetMapping("/cerca_parlamentare_dalla_circoscrizione")
public ModelAndView getParlamentare4(@RequestParam("circoscrizione") String 
 circoscrizionee)
{
    ModelAndView mv = new ModelAndView();
    List<Parlamentare> parlamentari = 
 parlamRepo.findByCircoscrizione(circoscrizionee);
    mv.addObject("parlamentari", parlamentari);
    mv.setViewName("lista_parlamentari_circoscrizione");       
    return mv;  
}*/
	
	
	@RequestMapping("/updateParlamentare")//modificche con pk
	public ModelAndView updateParlamentare(@RequestParam PK pk, Parlamentare nuovoparlamentare)
	{
		ModelAndView mv = new ModelAndView();
		Parlamentare vecchioparlamentare = parlamRepo.findByPk(pk);//.orElse(null);
		parlamRepo.delete(vecchioparlamentare);
		//modificato con pk
		if((pk.getNome()==nuovoparlamentare.getNome()) && (pk.getPartito()==nuovoparlamentare.getPartito()) && (pk.getCircoscrizione()==nuovoparlamentare.getCircoscrizione()))
		parlamRepo.save(nuovoparlamentare);
		Parlamentare parlamentare = nuovoparlamentare;
		mv.addObject(parlamentare);
		mv.setViewName("showParlamentare2.jsp");
		return mv;	
	}
	
	
	@RequestMapping("/cancella_parlamentare")
	public ModelAndView deleteParlamentare(Parlamentare parlamentare)
	{
		ModelAndView mv = new ModelAndView();
		parlamRepo.delete(parlamentare);
		Iterable<Parlamentare> parlamentari = parlamRepo.findAll();
		mv.addObject("parlamentari",parlamentari);
		mv.setViewName("parlamentareDeleted.jsp");
		return mv;	
	}	
	
	
	@RequestMapping("/lista_periodi_cariche")
	@ResponseBody
	public  ModelAndView getPeriodi_cariche() 
	{		
		ModelAndView mv = new ModelAndView();
		//Iterable<Parlamentare> parlamentari = parlamRepo.findAll();
		Iterable<Periodi_cariche> periodi_cariche = periodiRepo.findAll();
		mv.addObject("periodi_cariche", periodi_cariche);
	//	mv.addObject("parlamentari",parlamentari);
        mv.setViewName("lista_periodi_cariche.jsp");	
        return mv;
	}
	
	
	@RequestMapping("/Parlamento/parlamentare/{nome}")
	@ResponseBody
	public Parlamentare getParlamentare5(@PathVariable("nome") String nome) { 
		
		return parlamRepo.findByNome(nome);
	}
	
	//public 
	
	
	
	@RequestMapping("/error2")
    public String error() {
        return "Error handling";
    }
	
}
