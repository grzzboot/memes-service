package com.grzzboot.service.memes.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grzzboot.service.memes.resource.service.MemesService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
public class MemesWebController {

	private final MemesService memesService;

	@GetMapping("/meme")
	public String meme(Model model) {
		model.addAttribute("randomMeme", memesService.random().getMeme());
		return "meme";
	}

}
