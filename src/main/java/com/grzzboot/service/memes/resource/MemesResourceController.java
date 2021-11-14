package com.grzzboot.service.memes.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.grzzboot.service.memes.resource.model.MemeResource;
import com.grzzboot.service.memes.resource.service.MemesService;

@RestController
@RequestMapping(path = "memes", produces = { "application/json" })
public class MemesResourceController {

	private final MemesService memesService;

	@Autowired
	public MemesResourceController(MemesService memesService) {
		this.memesService = memesService;
	}

	@GetMapping(path = "random")
	public MemeResource random() {
		return new MemeResource(memesService.random().getMeme());
	}

}
