package com.grzzboot.service.memes.resource.service;

import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.grzzboot.service.memes.resource.service.domain.MemeEntity;
import com.grzzboot.service.memes.resource.service.repository.MemesRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
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
	
	public MemeEntity heavyRandom() {
		heavyCalc();
		List<MemeEntity> allMemes = memesRepository.getAll();
		return allMemes.get(new Random(System.currentTimeMillis()).nextInt(allMemes.size()));
	}

	private void heavyCalc() {
		long start = System.currentTimeMillis();
		long split = start;
		do {
			Math.log(new Random().nextLong());
			split = System.currentTimeMillis() - start;
		} while (split <= 100);
		log.info("Aborting expensive calculation after approx {} ms.", split);
	}

}
