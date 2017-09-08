# This is datafix that should be run only once to update
# link in guidance section. Runnig this more then once is OK,
# will create any invalid data, but this is uncessary.

namespace :one_time do

	desc "Update link in guidance section"
	task :datafix_issue140 => :environment do
    question1="How and where will your data be stored and backed up during your research project?"
    guidance1="<p>The risk of losing data due to human error, natural disasters, or other mishaps can be mitigated by following the <a href=\"http://dataabinitio.com/?p=501\" target=\"_blank\">3-2-1 backup rule</a>:<br><ul><li>Have at least three copies of your data.</li><li>Store the copies on two different media.</li><li>Keep one backup copy offsite</li></ul></p><p>Data may be stored using optical or magnetic media, which can be removable (e.g. DVD and USB drives), fixed (e.g. desktop or laptop hard drives), or networked (e.g. networked drives or cloud-based servers). Each storage method has benefits and drawbacks that should be considered when determining the most appropriate solution. </p><p>Further information on storage and backup practices is available from the <a href=\"https://www.sheffield.ac.uk/library/rdm/safedata\" target=\"_blank\">University of Sheffield Library</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/storage/back-up\" target=\"_blank\">UK Data Archive</a>.</p>"

    question2="Comment vos données seront-elles stockées et sauvegardées pendant votre projet de recherche et à quel endroit le seront-elles?"
    guidance2="<p>Le risque de perdre des données en raison d'une erreur humaine, de catastrophes naturelles ou d'autres mésaventures peut être atténué en respectant les <a href=\"http://dataabinitio.com/?p=501\" target=\"_blank\">3-2-1 règles de sauvegarde</a>:<br><ul><li>Posséder au moins trois copies de vos données.</li><li>Stocker les copies sur deux types de médias différents.</li><li>Conserver une copie de sauvegarde hors site</li></ul></p>Les données peuvent être stockées au moyen d'un média optique ou magnétique qui peut être amovible (p. ex. DVD et clés USB), fixe (p. ex. lecteurs de disque dur d'ordinateur de bureau ou d'ordinateur portatif) ou en réseau (p. ex. lecteurs en réseau ou serveurs basés sur l'infonuagique). Chaque méthode de stockage comporte des avantages et des inconvénients qui doivent être pris en considération au moment de déterminer la solution la plus appropriée. </p>De plus amples renseignements sur les pratiques de stockage et de sauvegarde sont disponibles sur les sites suivants : <a href=\"https://www.sheffield.ac.uk/library/rdm/safedata\" target=\"_blank\">University of Sheffield Library</a> and the <a href=\"http://www.data-archive.ac.uk/create-manage/storage/back-up\" target=\"_blank\">UK Data Archive</a>.</p>"

    qs1 = Question.where(text: question1)
    qs1.each do |question|
      question.guidance=guidance1
      question.save!
    end


    qs2 = Question::Translation.where(text: question2)
    qs2.each do |question|
      question.guidance=guidance2
      question.save!
    end

	end

end
