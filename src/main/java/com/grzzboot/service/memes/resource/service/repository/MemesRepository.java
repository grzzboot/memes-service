package com.grzzboot.service.memes.resource.service.repository;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.grzzboot.service.memes.resource.service.domain.MemeEntity;
import com.grzzboot.service.memes.resource.service.repository.mapper.MemeRowMapper;

@Repository
public class MemesRepository {

	private final JdbcTemplate jdbcTemplate;

	@Autowired
	public MemesRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public List<MemeEntity> getAll() {
		return jdbcTemplate.query("SELECT MEME FROM MEMES", new MemeRowMapper());
	}

}
