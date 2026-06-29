# PyMOL Command Script for Target-Ligand Hit Complexes
# Load structural coordinates
load protein_clean.pdb, receptor
load docking_results.pdbqt, lead_ligand

# Format structural views
hide everything
show cartoon, receptor
show sticks, lead_ligand
color gray70, receptor

# Target binding pocket orientation
select pocket, receptor within 5.0 of lead_ligand
show sticks, pocket
color marine, pocket
util.cnc pocket

# Highlight the -CF3 Optimized Lead Candidate
color magenta, lead_ligand
util.cnc lead_ligand
preset.ball_and_stick("lead_ligand")

# Final visual settings
orient lead_ligand
bg_color white
set ray_shadows, 0
set cartoon_transparency, 0.3
