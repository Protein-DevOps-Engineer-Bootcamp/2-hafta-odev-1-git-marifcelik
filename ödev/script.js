const express = require('express');
const app = express();

const port = process.env.port || 3030
const host = 'localhost'

const kisiler = [
    {
        id: 1,
        ad: 'arif',
        yas: 21,
        yetenekler: ['nodejs', 'linux', 'javascript', 'docker']
    },
    {
        id: 2,
        ad: 'kadir',
        yas: 22,
        yetenekler: ['kafkas', 'zeybek', 'horon', 'halay', 'sparta']
    }
]

app.set('view engine', 'ejs')
app.use('/assets', express.static('assets'))

app.get('/', (req, res) => {
    res.render('index')
})

app.get('/profil', (req, res) => {
    // const veri = { ad: req.params.kisi, yas: 22, arr: ['Something In The Way', 'Way Down We Go'] };
    const veri = Object.keys(req.query).length != 0 ? (kisiler.find(kisi => kisi.ad == req.query.ad) || { hata: true }) : undefined;
    res.render('profile', veri);
})

app.get('/contact', (req, res) => {
    res.render('contact')
})

app.listen(port, host, console.log(`${host}:${port} dinleniyor...`))
