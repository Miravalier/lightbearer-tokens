CONVERTER := python3.7 -m svg
DATA_ROOT := /home/miravalier/Projects/foundry/foundrydata/Data
ABILITY_ROOT := ${DATA_ROOT}/Abilities
ENTITY_ROOT := ${DATA_ROOT}/Entities

ABILITIES := $(patsubst abilities/%,%,$(wildcard abilities/*.svg))
ENTITIES := $(patsubst entities/%,%,$(wildcard entities/*.svg))

GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Neutral/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Hostile/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Guardian/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Druid/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Assassin/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Necromancer/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Cleric/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Illusionist/%,${ABILITIES})
GENERATED_ABILITIES += $(patsubst %,${ABILITY_ROOT}/Elementalist/%,${ABILITIES})

GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Neutral/Portraits/%.svg,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Neutral/Tokens/%.png,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Hostile/Portraits/%.svg,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Hostile/Tokens/%.png,${ENTITIES})

ABILITY_OUTPUTS := Neutral Hostile Guardian Druid Assassin Necromancer Cleric Illusionist Elementalist
ENTITY_OUTPUTS := Neutral/Portraits Hostile/Portraits Neutral/Tokens Hostile/Tokens
OUTPUT_DIRS += $(patsubst %,${ABILITY_ROOT}/%,${ABILITY_OUTPUTS})
OUTPUT_DIRS += $(patsubst %,${ENTITY_ROOT}/%,${ENTITY_OUTPUTS})

${ABILITY_ROOT}/Neutral/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Hostile/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Guardian/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Druid/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Assassin/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Necromancer/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Cleric/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Illusionist/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Elementalist/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ENTITY_ROOT}/Neutral/Portraits/%.svg: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ENTITY_ROOT}/Neutral/Tokens/%.png: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Circle

${ENTITY_ROOT}/Hostile/Portraits/%.svg: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ENTITY_ROOT}/Hostile/Tokens/%.png: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Circle


all: generate

folders:
	@mkdir -p ${OUTPUT_DIRS}

misc: default_image.svg
	@${CONVERTER} $< ${ENTITY_ROOT}/$< --shape Circle
	@${CONVERTER} $< ${ABILITY_ROOT}/$< --shape Square

generate: folders misc ${GENERATED_ABILITIES} ${GENERATED_ENTITIES}
