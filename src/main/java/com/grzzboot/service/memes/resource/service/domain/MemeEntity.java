package com.grzzboot.service.memes.resource.service.domain;

import java.io.Serializable;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;

@RequiredArgsConstructor
@Getter
@ToString
public class MemeEntity implements Serializable {

	private static final long serialVersionUID = 4499451332190922486L;

	private final String meme;

}
