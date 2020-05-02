#!/usr/bin/env python3.7

import re
import os
from pathlib import Path

# Counter
images_processed = 0

# Constants
SQUARE_CLIP = r'<path d="M10 10h492v492H10z" fill="url(#gradient-0)" stroke="#000000" stroke-opacity="1" stroke-width="10" transform="translate(-102.4, -102.4) scale(1.4, 1.4) rotate(0, 256, 256)"></path>'
SQUARE_BG = r'<path d="M10 10h492v492H10z" fill="url(#gradient-0)" stroke="#000000" stroke-opacity="1" stroke-width="10"></path>'
CLIP_PATH = 'clip-path="url(#icon-bg)"'
CIRCLE_CLIP = r'<circle cx="256" cy="256" r="246" fill="url(#gradient-0)" stroke="#000000" stroke-opacity="1" stroke-width="10" transform="translate(-51.2, -51.2) scale(1.2, 1.2) rotate(0, 256, 256)"></circle>'
CIRCLE_BG = r'<circle cx="256" cy="256" r="246" fill="url(#gradient-0)" stroke="#000000" stroke-opacity="1" stroke-width="10"></circle>'

ABILITY_CATEGORIES = {
    "Guardian": "#64AAE8", "Druid": "#5C451A", "Assassin": "#81419F",
    "Necromancer": "#19A713", "Cleric": "#FFC932", "Illusionist": "#FFC9F2",
    "Elementalist": "#FF7D00", "Neutral": "#FFFFFF", "Hostile": "#A91212"
}
ENTITY_CATEGORIES = {
    "Neutral": "#FFFFFF", "Hostile": "#A91212"
}

token_root = Path('/home/miravalier/Projects/foundry/tokens')
data_root = Path('/home/miravalier/Projects/foundry/foundrydata/Data/')
ability_root = data_root / "Abilities"
entity_root = data_root / "Entities"


# Ensure ability input directory
abilities = token_root / "abilities"
abilities.mkdir(parents=True, exist_ok=True)

# Ensure ability output directories
for category in ABILITY_CATEGORIES:
    (ability_root / category).mkdir(parents=True, exist_ok=True)

# Parse all ability images
for image in (p for p in abilities.iterdir() if p.is_file() and p.suffix == '.svg'):
    # Read ability data
    image_data = image.read_text()
    # Remove style tags
    image_data = re.sub(
        r'style\s*=\s*"[^"]*"',
        ' ',
        image_data
    )
    for category in ABILITY_CATEGORIES:
        # Alter color
        recolored_image_data = re.sub(
            r'fill\s*=\s*"#[A-Fa-f0-9]{6}"',
            'fill="{}"'.format(ABILITY_CATEGORIES[category]),
            image_data
        )
        # Write square version
        (ability_root / category / image.name).write_text(
            recolored_image_data.replace(
                CIRCLE_BG, SQUARE_BG
            ).replace(
                CIRCLE_CLIP, SQUARE_CLIP
            ).replace(
                CLIP_PATH, ""
            )
        )
    # Increment counter
    images_processed += 1


# Ensure entity input directory
entities = token_root / "entities"
entities.mkdir(parents=True, exist_ok=True)

# Ensure entity output directories
for category in ENTITY_CATEGORIES:
    (entity_root / category / "Portraits").mkdir(parents=True, exist_ok=True)
    (entity_root / category / "Tokens").mkdir(parents=True, exist_ok=True)

# Parse all entity images
for image in (p for p in entities.iterdir() if p.is_file() and p.suffix == '.svg'):
    # Read ability data
    image_data = image.read_text()
    # Remove style tags
    image_data = re.sub(
        r'style\s*=\s*"[^"]*"',
        ' ',
        image_data
    )
    for category in ENTITY_CATEGORIES:
        # Alter color
        recolored_image_data = re.sub(
            r'fill\s*=\s*"#[A-Fa-f0-9]{6}"',
            'fill="{}"'.format(ENTITY_CATEGORIES[category]),
            image_data
        )
        # Write circle version
        (entity_root / category / "Tokens" / image.name).write_text(
            recolored_image_data.replace(SQUARE_BG, CIRCLE_BG).replace(SQUARE_CLIP, CIRCLE_CLIP)
        )
        # Write square version
        (entity_root / category / "Portraits" / image.name).write_text(
            recolored_image_data.replace(
                CIRCLE_BG, SQUARE_BG
            ).replace(
                CIRCLE_CLIP, SQUARE_CLIP
            ).replace(
                CLIP_PATH, ""
            )
        )
    # Increment counter
    images_processed += 1


print("Processed {} images".format(images_processed))

'''
# Write stamp version
(ability_root / category / image.name).write_text(
    recolored_image_data.replace(
        CIRCLE_BG, ""
    ).replace(
        SQUARE_BG, ""
    ).replace(
        CIRCLE_CLIP, SQUARE_CLIP
    ).replace(
        CLIP_PATH, ""
    )
)
'''
