package com.grzzboot.service.memes.resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.grzzboot.service.memes.resource.model.MemeResource;
import com.grzzboot.service.memes.resource.service.MemesService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping(path = "memes", produces = { "application/json" })
@Slf4j
public class MemesResourceController {

	private final MemesService memesService;

	@Autowired
	public MemesResourceController(MemesService memesService) {
		this.memesService = memesService;
	}

	@GetMapping(path = "random")
	public MemeResource random(@RequestParam(required = false, defaultValue = "false") boolean heavy) {
		if (heavy) {
			log.info("Running a heavy random");
			return new MemeResource(memesService.heavyRandom().getMeme());
		} else {
			log.info("Running a normal random");
			return new MemeResource(memesService.random().getMeme());
		}
	}

}
