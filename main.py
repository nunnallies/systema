# This example requires the 'message_content' intent.

import discord
from discord.ext import commands
from random import randint
import sqlite3
import mysql.connector



intents = discord.Intents.default()
intents.message_content = True
bot = commands.Bot(command_prefix="s!",intents=intents)

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="systema"
)

def creerinventaire(idperso):
    cursor=conn.cursor()
    request="INSERT INTO `inventaire` (IDPERSONNAGE) VALUES ('"+str(idperso)+"')"
    cursor.execute(request)
    conn.commit


def ajoutperso(nom,region,iddiscord):
    cursor = conn.cursor()
    request="INSERT INTO `personnages` (nom,region,iddiscord) VALUES" + "('" +nom + "','"+  region + "','"+ str(iddiscord)+"')"
    cursor.execute(request)
    cursor.execute("SELECT LAST_INSERT_ID()")
    idperso= cursor.fetchone()[0]
    creerinventaire(idperso)
    conn.commit()
    return(idperso)

def ajoutitem(nom,rarete,description,idinventaire):
    cursor=conn.cursor()
    description = description.replace("'", "''")
    nom=nom.replace("'", "''")
    request="INSERT INTO `objets` (nom,rarete,description,IDINVENTAIRE) VALUES ('"+nom+"','"+rarete+"','"+description+"','"+str(idinventaire)+"')"
    cursor.execute(request)
    conn.commit()

def get_inventaire_id_from_perso_id(idperso):
    cursor=conn.cursor()
    request="SELECT `IDINVENTAIRE` FROM `inventaire` WHERE `IDPERSONNAGE`="+str(idperso)
    cursor.execute(request)
    idinventaire=cursor.fetchone()[0]
    conn.commit()
    return(idinventaire)

def getrequiredxrp(lvl):
    cursor=conn.cursor()
    request="SELECT `XPREQUIS` FROM `niveau` where `lvl`='"+str(lvl)+"'"
    cursor.execute(request)
    requiredxp=cursor.fetchone()[0]
    conn.commit()
    return(requiredxp)

def get_persoid_from_name(nom):
    cursor=conn.cursor()
    request="SELECT `IDPERSONNAGE` FROM `personnages` WHERE `nom`='"+str(nom)+"'"
    cursor.execute(request)
    persoid=cursor.fetchone()[0]
    conn.commit()
    return(persoid)

def get_region_from_name(nom):
    cursor = conn.cursor()
    request = "SELECT `REGION` FROM `personnages` WHERE `nom`='" + str(nom)+"'"
    cursor.execute(request)
    region=cursor.fetchone()[0]
    conn.commit()
    return(region)

def get_lvl_from_name(nom):
    cursor = conn.cursor()
    request = "SELECT `lvl` FROM `personnages` WHERE `nom`='" + str(nom)+"'"
    cursor.execute(request)
    lvl = cursor.fetchone()[0]
    conn.commit()
    return (lvl)

def get_progressionxp_from_name(nom):
    cursor = conn.cursor()
    request = "SELECT `progressionxp` FROM `personnages` WHERE `nom`='" + str(nom)+"'"
    cursor.execute(request)
    progressionxp= cursor.fetchone()[0]
    conn.commit()
    return (progressionxp)

def progressbar(progressionxp,requiredxp):
    x=(25*progressionxp)/requiredxp
    progress="| "
    for i in range (25) :
        if i<x:
            progress=progress+"█"
        else :
            progress = progress + "░"
    progress=progress+" |"

    return progress

def get_personnages_from_id(id):
    cursor = conn.cursor()
    request = "SELECT * FROM `personnages` WHERE `iddiscord`='" + str(id) + "'"
    cursor.execute(request)
    personnages = cursor.fetchall()
    conn.commit()
    return (personnages)

def get_objects_from_inventaireid(inventaireid):
    cursor = conn.cursor()
    request = "SELECT * FROM `objets` WHERE `IDINVENTAIRE`='" + str(inventaireid) + "'"
    cursor.execute(request)
    objets = cursor.fetchall()
    conn.commit()
    return (objets)


@bot.command(name='starter_pack')
async def starter_pack(ctx, *args):
    arguments = ', '.join(args)
    liste_objets = [
        ["couteau de chasse", "C",""" une lame rouillée, c’naze"""],
        ["boîtes d’allumettes", "B", """Il n’y a que 32 allumettes, attention aux voeux, haha"""],
        ["boites de conserves pleines", "B","""t’as cru que j’allais donner mieux ?"""],
        ["un caillou", "D", """À défaut de t’le jeter dessus…"""],
        ["une clé", "A", """C’est la clé de mon coeur"""],
        ["un kit de soins", "A","""Pour t’soigner si t’ as des égratignures"""],
        ["une écharpe", "C","""Pour tes soirées de célibat et solitude"""],
        ["""une bouteille d’alcool""", "B", """Si tu bois ça en une fois, t’en as dans le slibard"""],
        ["un paquet de pâtes", "B", """On sait jamais si t’as faim"""],
        ["du riz", "A", """Avec un peu plus d’ingrédients, t’peux faire une dinguerie"""],
        ["""de l’eau potable""", "S", """T’as de la chance de commencer avec ça, j’vais cracher dedans attend"""],
        ["un sac de pièces", "D", """Ah ! J’ai récupéré ça lors de mon voyage en France."""],
        ["un sac a dos", "D", "Tututu Dora"],
        ["une couverture", "B", "Les nuits sont fraîches ici"],
        ["un Briquet", "B", "La flamme de notre amour"],
        ["du Bois", "B", "Bob le bucheron"],
        ["un parfum pour homme", "D", """J’oserais pas dire que tu pues, nooon"""],
        ["une paire de chaussette sale", "D", "Oh, elles étaient là !"],
        ["un rouleau d'aluminium", "C", """J’sais pas, pas d’inspi"""],
        ["un bouchon en liège", "D", "Héhé"],
        ["des serviettes hygièniques", "S", "Pour certaines personnes ça peut servir..!"],
        ["une fourchette", "B", "Tu manges avec les mains ? Ew"],
        ["une cuillère", "B", "Slurp"],
        ["une assiette", "B", "Un peu de dignité, mange pas dans un vieux truc"],
        ["""mode d'emploi Ikea""", "A", """j’avais ça dans mon sac"""],
        ["un parapluie", "A", """L’eau ici pique comme de l’acide !"""],
        ["un paquet de croquette", "D", "... Aboie pour voir"],
        ["un Yo-yo", "D", """Oh, c’est mon préféré dans la collection !"""],
        ["un dentier utilisé", "D", "Oops !"],
        ["un stylo", "B", "Dans les séries ils font des trucs cools avec"],
        ["un bocal de vers de terre vivants", "D", "Ewww ! "],
        ["un canard en plastique", "B", """Mister coin-coin peut être utile !"""],
        ["un pot de peinture", "B", "Une baby shower prévue ? Non ? Tant pis"],
        ["une canne à pêche", "S", """J’ai jamais compris comment ça marche"""],
        ["un LEGO à monter", "A", "Tu vas voir, il est cool avec la voiture de police !"],
        ["un gel Hydroalcolique", "S", "Utile pour éviter des maladies infectieuses"],
        ["""un costume d'indien""", "D", "... Il vendait ça pas cher"],
        ["un tanga", "D", " No description needed"],
        ["des lunettes de soleil", "C", "En mode Men In Black !"],
        ["des jouets pour enfants", "C", """Pour t’amuser les jours de pluie"""],
        ["de la nourriture avariée", "D", """Je devais m’en débarrasser"""],
        ["des fleurs en plastique","C", "Joyeuse Saint Valentin !"],
        ["un miroir", "B", "Admire ta beauté tant que tu le peux encore"],
        ["des chaussures", "B", "Utile pour éviter de se blesser"],
        ["des lingots de fer", "S", """En vrai c’est giga lourd !"""],
        ["une carte mystère", "S", """Y’a un lieu d’écrit dessus avec un trésor, bonne chance"""],
        ["""des feux d’artifice""""", "A", """C’est pas mal pour se diriger dans le noir"""],
        ["instrument de musique", "B", """J’sais faire de l’harmonica, tu sais faire quoi, toi ?"""],
        ["marteau et trois clous", "B", """J’suis radin, j’sais"""],
        ["tournevis", "B", "Le perd pas"],
        ["pièces électroniques", "A", """Si t’es un génie, ça peut être intéressant"""],
        ["trois produits de beauté", "B", """Prendre soin de sa peau c’est toujours important !"""],
        ["des bougies", "A", """Pour voir dans le noir ou l’odeur, j’sais pas"""],
        ["une montre à gousset", "S", "La direction est toujours bien indiquée"],
        ["""une cape d’invisibilité""", "S","""… BAHAHA"""],
        ["une boisson augmentant les capacités physiques", "S", "Remercie-moi plus tard"],
        ["""une invocation d’un monstre divin""", "S", """Il est un peu rochon mais il est sympa une fois qu’il a mangé"""],
        ["""de l’essence""", "A", """Evite de faire n’importe quoi avec"""],
        ["""de l’huile de cuisson""", "B", """Pour faire cuire ta viande c’est pas mal"""]
    ]
    Region = ['Pyredia','Elidia','Solemn','Lavernia']
    randregion=randint(0,3)
    id=ajoutperso(args[0],Region [randregion],ctx.author.id)

    starter=[]
    rand1=randint(0,3)
    if rand1 != 0 :
        for i in range (rand1) :
            rand2=randint(0,len(liste_objets)-1)
            ajoutitem(liste_objets[rand2][0],liste_objets[rand2][1],liste_objets[rand2][2],get_inventaire_id_from_perso_id(id))
            starter.append(liste_objets[rand2][0])
        msg = """Assis sur le bord de son rocher, **Amésis,** divinité déchue, observe l'horizon avec un ennui qui ne peut être dissimulé. Ce n'est que lorsque le vent se lève, lui indiquant la présence d'un inconnu, qu'il tourne son regard vidé de ses émotions en ta direction. 
Sa main droite s'ouvre lentement pour laisser apparaître une carte avec d'étranges écritures. 

>> {} pauvre âme égarée, bienvenue en ce monde. La carte vole en ta direction. ***Sur cette carte tu vas trouver de quoi survivre, ou non, quelques temps. Bon courage. Rends toi à {} pour la suite. . .***

Une fois la carte entre tes mains les écritures deviennent plus claires et tu peux désormais lire ce qui t'es offert pour ta survie. Tu peux notamment y voir inscrite la liste suivante : {}. Un peu plus bas sur la carte, en plus petit on peut y voir inscrit la mention suit : 'Afin d'obtenir vos objets, merci de déchirer cette carte.'""".format(
            args[0],Region [randregion], ', '.join(starter))
    else :
        msg ="""Assis sur le bord de son rocher, Amésis, divinité déchue, observe l'horizon avec un ennui qui ne peut être dissimulé. Ce n'est que lorsque le vent se lève, lui indiquant la présence d'un inconnu, qu'il tourne son regard vidé de ses émotions en ta direction. 
Sa main droite s'ouvre lentement pour laisser apparaître... Rien. 

***Bonjour {}, bienvenue à Astra. Pas de starter pack pour toi j'aime pas trop ta gueule. Va là-bas, tu vas pouvoir trouver... Euhm... Ton seum ? HAHAHAH.***

Le vent se lève soudainement, dévoilant les perles grises de l'être moqueur, une pointe de sadisme naissant dans le fond de celles-ci. 


***Les choses font que tu vas devoir fouiller et trouver des choses par toi-même en ce monde. Bonne chance et bon courage. Rends toi à {} pour la suite. . .***""".format(
            args[0],Region [randregion])

    await ctx.send(msg)


@bot.command(name="profile")
async def profile(ctx,*args):
    region=get_region_from_name(args[0])
    niveau=get_lvl_from_name(args[0])
    progresionxp=get_progressionxp_from_name(args[0])
    requiredxp=getrequiredxrp(niveau)
    embed=discord.Embed(title=args[0],description="❝𝓞h 𝓓ear soul. . . ! 𝓜ay your days be 𝑏𝑙𝑒𝑠𝑠𝑒𝑑 in 𝐴𝑠𝑡𝑟𝑎. ❞\n")
    embed.add_field(name="｡☆✼★━━━━━━━━━━━━★✼☆｡", value="\n\nRésident de la région de "+ region + ".",
                    inline=False)
    embed.add_field(name="Niveau " + str(niveau), value=progressbar(progresionxp,requiredxp) +" "+  str(progresionxp)+ "/" + str(requiredxp),
                    inline=False)

    await ctx.send(embed=embed)

@bot.command(name='inventaire')
async def inventaire(ctx,*args):
    perso = get_personnages_from_id(ctx.author.id)
    if not perso:
        await ctx.send("Vous n'avez pas de personnages.")
        return
    # Créer un menu déroulant avec les personnages
    dropdown = discord.ui.Select(
        placeholder="Sélectionnez un personnage",
        options=[
            discord.SelectOption(label=perso[i][1], value=str(perso[i][0])) for i in range(len(perso))
        ]
    )

    async def dropdown_callback(interaction: discord.Interaction):
        selected_option = interaction.data['values'][0]
        selected_perso = None
        for p in perso:
            if str(p[0]) == selected_option:
                selected_perso = p
                break
        if selected_perso:
            # Obtenez l'inventaire du personnage sélectionné
            inventaire = get_objects_from_inventaireid(get_inventaire_id_from_perso_id(selected_perso[0])) # Remplacez obtenir_inventaire par votre fonction pour obtenir l'inventaire

            # Créer un embed pour afficher l'inventaire
            embed = discord.Embed(
                title=f"Inventaire de {selected_perso[1]}",
                description="Voici l'inventaire de votre personnage :",
                color=discord.Color.blue()
            )

            if not inventaire :
                embed.add_field(name="Hm...",value="""C'est vide par ici. . . """,
                                inline=False)
            else :
                for item in inventaire:
                    embed.add_field(name=item[1], value="『"+item[2]+"』» " + item[3],
                                inline=False)
            # Envoyer l'embed
            await interaction.response.edit_message(embed=embed)
        else:
            await interaction.response.send_message("Erreur: Personnage non trouvé.")

    # Créer une vue et y ajouter le menu déroulant
    view = discord.ui.View()
    view.add_item(dropdown)

    embed = discord.Embed(
        title="Inventaire",
        description="Sélectionnez un personnage pour afficher son inventaire.",
    )
    message = await ctx.send(embed=embed, view=view)
    dropdown.callback = dropdown_callback

@bot.command(name='quete')
async def quete(ctx,*args):
    perso = get_personnages_from_id(ctx.author.id)



@bot.command(name='info')
async def info(ctx,*args):
    arguments = ', '.join(args)
    n=len(args)
    eldia_texte = """Elidia, une ville mystérieusement figée dans le temps au cœur d'un paysage glacé. Ses rues pavées, autrefois animées par l'activité humaine, sont maintenant désertes. Les façades des maisons, malgré leur apparence abandonnée, conservent une aura de confort et de douceur.
 

Les habitations sont comme des capsules temporelles gelées, préservant l'atmosphère accueillante qui régnait autrefois. Les fenêtres aux volets entrouverts laissent entrevoir des intérieurs chaleureux, des cheminées en pierre éteintes, des canapés moelleux et des couvertures soigneusement disposées. Les tables de cuisine portent encore des traces de repas familiaux, laissant l'impression que les habitants se sont levés un jour et ont simplement disparu.


Les arbres, d'anciens gardiens robustes sont parés de cristaux de glace étincelants, semblent veiller silencieusement sur la ville abandonnée, en mémoire du passé.

​

Au centre d'Eldia, une place principale accueille une fontaine gelée qui fige l'eau en cascade éternelle. Des bancs vides entourent la place, invitant autrefois les habitants à profiter de moments paisibles sous les flocons de neige dérivant lentement du ciel.

Les boutiques autrefois vivantes affichent des devantures défraîchies, mais à l'intérieur, les étagères regorgent de produits soigneusement rangés, comme si les commerçants attendaient simplement le retour de leurs clients.

C'est une ville suspendue dans le temps, capturée dans une beauté froide et tranquille, attendant peut-être que la vie reprenne vie entre ses murs accueillants.

Même si le temps semble s'être arrêté et que la ville s'est endormie sous des couches épaisses de neiges froides, elle regorge d'anciens gardiens dont la colère n'a pas su s'apaiser avec le temps. 
Abandonnés, délaissés, oubliés, ils sont désormais des dangers pour toute sorte de vie... Vérifiez bien sous vos lits, verrouillez vos portes et fenêtres, **le danger n'est jamais loin**."""
    pyredia_texte="""Pyredia, une ville autrefois prospère nichée aux abords d'une vaste forêt enchantée.
Jadis, les habitants vivaient en harmonie avec la nature luxuriante qui les entourait, mais le temps a laissé ses empreintes, transformant la ville en une merveille abandonnée où la nature a repris ses droits.

Les rues pavées de la ville sont maintenant recouvertes d'un tapis de mousse douce et de pétales de fleurs multicolores. 
Les vignes grimpent le long des murs, créant un tableau vivant de verdure et de fleurs qui contrastent avec l'architecture vieillissante.
 

Les habitations abandonnées dégagent une atmosphère mélancolique, mais les intérieurs résistent au temps avec une certaine élégance décrépite. Des plantes d'intérieur luxuriantes ont envahi les espaces autrefois habités, conférant une beauté sauvage aux foyers déserts.Les fenêtres brisées laissent entrer la lumière, créant une atmosphère magique où la frontière entre l'intérieur et l'extérieur est délicate.

La forêt enchantée qui borde la ville offre un spectacle extraordinaire. Des arbres majestueux s'entremêlent avec des vignes suspendues, créant des voûtes naturelles. Des fleurs exotiques aux couleurs vives tapissent le sol, et des lucioles dansent à la lueur du crépuscule, ajoutant une touche féerique à l'ensemble.

Malgré son apparence déserte, Pyredia reste habitée par une poésie naturelle.
La ville, bien que délaissée, offre une nouvelle forme de vie, où l'homme et la nature coexistent dans une danse harmonieuse.

Les arbres semblent farceur puisque beaucoup de nouveaux visiteurs se perdent et ne reviennent jamais... La plus part des plantes mangeables sont devenues toxiques, faisant souffrir les plus malheureux de plusieurs maux divers jusqu'à la mort.

**Méfiez-vous**."""
    if args[0]=='Elidia' or args[0]=='elidia' or args[0]=='elydia' or args[0]=='Elydia' :
        if n>1 and (args[1]=='more' or args[1]=='More'):
            await ctx.send(eldia_texte)
        else :
            await ctx.send(file=discord.File('elidia.png'))
    elif args[0]=='Pyredia' or args[0]=='pyredia' :
        if n>1 and (args[1]=='more' or args[1]=='More'):
            await ctx.send(pyredia_texte)
        else :
            await ctx.send(file=discord.File('pyredia.png'))
    else :
        await ctx.send("""Je n'ai pas compris ta demande. Veux-tu des informations sur astra ? Si oui, tape s!info astra, pour avoir des infos plus détaillées tu peux rajouter more après l'entité que tu cherches par exemple :\n s!info astra more\n Concernant les régions il y a : Elidia, Pyredia, Solemn, Lavernia. Tu peux afficher les infos de la même façon.""")




bot.run("MTIxMDMwMjYwMTMyNTg0NjY2MA.GYfMec.6vFNnhVDLn66EL3odPF4cAXJ6ba1ryLMvFlApQ")