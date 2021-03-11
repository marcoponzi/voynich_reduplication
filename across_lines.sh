# full reduplication across line breaks
cat texts/vms/EVA | tr '\n' '_' | \
grep -o '[^a-z]\([a-z][a-z][a-z]*\)[^a-z]*_<[^>]*>[^a-z]*\1[^a-z]'
