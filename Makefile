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

GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Neutral/Square/%.svg,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Neutral/Circle/%.png,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Hostile/Square/%.svg,${ENTITIES})
GENERATED_ENTITIES += $(patsubst %.svg,${ENTITY_ROOT}/Hostile/Circle/%.png,${ENTITIES})

ABILITY_OUTPUTS := Neutral Hostile Guardian Druid Assassin Necromancer Cleric Illusionist Elementalist
ENTITY_OUTPUTS := Neutral/Square Hostile/Square Neutral/Circle Hostile/Circle
OUTPUT_DIRS += $(patsubst %,${ABILITY_ROOT}/%,${ABILITY_OUTPUTS})
OUTPUT_DIRS += $(patsubst %,${ENTITY_ROOT}/%,${ENTITY_OUTPUTS})


${ABILITY_ROOT}/Neutral/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ABILITY_ROOT}/Hostile/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#A91212" --shape Square

${ABILITY_ROOT}/Guardian/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#64AAE8" --shape Square

${ABILITY_ROOT}/Druid/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#5C451A" --shape Square

${ABILITY_ROOT}/Assassin/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#81419F" --shape Square

${ABILITY_ROOT}/Necromancer/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#19A713" --shape Square

${ABILITY_ROOT}/Cleric/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFC932" --shape Square

${ABILITY_ROOT}/Illusionist/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FFC9F2" --shape Square

${ABILITY_ROOT}/Elementalist/%.svg: abilities/%.svg
	${CONVERTER} $< $@ --fg "#FF7D00" --shape Square


${ENTITY_ROOT}/Neutral/Square/%.svg: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Square

${ENTITY_ROOT}/Neutral/Circle/%.png: entities/%.svg
	${CONVERTER} $< $@ --fg "#FFFFFF" --shape Circle

${ENTITY_ROOT}/Hostile/Square/%.svg: entities/%.svg
	${CONVERTER} $< $@ --fg "#A91212" --shape Square

${ENTITY_ROOT}/Hostile/Circle/%.png: entities/%.svg
	${CONVERTER} $< $@ --fg "#A91212" --shape Circle


all: generate

folders:
	@mkdir -p ${OUTPUT_DIRS}

generate: folders ${GENERATED_ABILITIES} ${GENERATED_ENTITIES}
