package com.grzzboot.service.memes.resource.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grzzboot.service.memes.resource.service.domain.MemeEntity;
import com.grzzboot.service.memes.resource.service.repository.MemesRepository;

@Service
public class MemesService {

	private final MemesRepository memesRepository;

	@Autowired
	public MemesService(MemesRepository memesRepository) {
		this.memesRepository = memesRepository;
	}

	public MemeEntity random() {
		List<MemeEntity> allMemes = memesRepository.getAll();
		return allMemes.get(new Random(System.currentTimeMillis()).nextInt(allMemes.size()));
	}

}
