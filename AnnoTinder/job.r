library(annotinder)
source('AnnoTinder/units.r')
source('AnnoTinder/train_units.r')
source('AnnoTinder/codebook.r')


n_tweets = 1860
n_anno = 30
overlap = 5

n_batches = n_tweets / n_anno
batch_indices = rep(1:n_batches, each=n_anno)
batches = split(unit_ids[1:n_tweets], batch_indices)

## The estimated 330 codes falls 3 coders short...
message(sprintf('Need %s coders per condition to code %s units with %s overlap and %s units per coder', 
        length(batches)*overlap, n_tweets, overlap, n_anno))


## create a jobset for every batch
jobsets = lapply(1:length(batches), function(i) {
  jobset(name = paste0('batch_', i), ids=batches[[i]])
})

## example jobsets
jobsets[[1]]
jobsets[[40]]


## Create debriefing for redirecting after job is finished
debrief_msg = "Klik on de onderstaande link om het onderzoek af te ronden."
debrief_condition1 = debrief(message=debrief_msg, link = "https://dkr1.ssisurveys.com/projects/end?rst=1&psid={psid}", "Klik hier!")
## ... 6 keer link terug naar qualtrics, of 1 keer als er een enkele return link is naar het panel bureau


## Upload job
backend_connect('https://annotinder.up.railway.app', 'a.c.kroon@uva.nl')

upload_job("AnnoBias link test", units=intro_unit_1, codebook=codebook, debrief=debrief_condition1)
## "https://annotinder.com/?host=https://annotinder.up.railway.app&jobtoken=eyJhbGciOiJIUzI1NiJ9.eyJqb2IiOiA4NiwgImV4cGlyZXMiOiBudWxsfQ.CYIOOzqpUpI3JTiL3WV84goxdP0B8ELjoW5v1Eqse5o&user_id=123&psid=777"

upload_job("AnnoBias job final, set 1", units=units_condition_1_2_3, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)
upload_job("AnnoBias job final, set 2", units=units_condition_1_2_3, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)
upload_job("AnnoBias job final, set 3", units=units_condition_1_2_3, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)
upload_job("AnnoBias job final, set 4", units=units_condition_4_5_6, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)
upload_job("AnnoBias job final, set 5", units=units_condition_4_5_6, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)
upload_job("AnnoBias job final, set 6", units=units_condition_4_5_6, codebook=codebook, pre=intro_units, jobsets=jobsets, debrief=debrief_condition1)


create_job('voorbeeld', units=units_condition_1_2_3, codebook=codebook) |>
  create_job_db(overwrite=T) |>
  start_annotator()


units <- c(intro_unit_1, intro_unit_2, train_unit_1,  train_unit_2)


create_job('voorbeeld', units=units, codebook=codebook) |>
  create_job_db(overwrite=T) |>
  start_annotator()