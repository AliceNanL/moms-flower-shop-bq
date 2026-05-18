PROJECT=dbt-learning-path-496700
DATASET=example
BUCKET=gs://moms-flower-shop-data

gsutil ls "${BUCKET}/*.csv" | while read -r uri; do
  table=$(basename "$uri" .csv | tr '-' '_')
  echo "Loading $uri → $table"

  bq load \
    --project_id="${PROJECT}" \
    --autodetect \
    --skip_leading_rows=1 \
    --source_format=CSV \
    "${DATASET}.${table}" \
    "$uri" </dev/null
done