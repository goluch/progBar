package pl.treecmp.progressbar.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.context.annotation.SessionScope;
import org.springframework.web.servlet.ModelAndView;

import pl.treecmp.progressbar.logic.Task;

@Controller
@SessionScope
@RequestMapping(value = "/task")
public class TaskController {

	//private Task task = new Task();
	private Task task = null;
	
    @RequestMapping("")
    protected ModelAndView page() {
        ModelAndView model = new ModelAndView("task");

        if (this.task == null) {
            this.task = new Task();
        }

        model.addObject("task", this.task);

        return model;
    }

    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public @ResponseBody
    String getStatus() {

        return task.getStatus();
    }

    /*@RequestMapping(value = "/progress", method = RequestMethod.GET)
    public @ResponseBody
    int getProgress() {

        return task.getProgress();
    }*/
    
    @RequestMapping(value = "/progress", method = RequestMethod.GET)
    public @ResponseBody
    String getProgress() {

        return Integer.toString(task.getProgress());
    }

    @RequestMapping(value = "/form", method = RequestMethod.POST)
    public ModelAndView form(@ModelAttribute Task task) {

        this.task = task;
        ModelAndView model = new ModelAndView("task");
        try {
			task.execute();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        model.addObject("task", this.task);
        return model;
    }

}