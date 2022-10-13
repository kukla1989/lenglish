import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["name"]

    connect() {
        let translated_articles = document.getElementById("translated_article").value
        let translated_arr = translated_articles.match(/[^\.!\?]+[\.!\?]+["']?|\s*$/g)
        let article_arr = this.name.match(/[^\.!\?]+[\.!\?]+["']?|\s*$/g)
        this.arr = []
        for (let i = 0; i < translated_arr.length; i++){
            this.arr.push(article_arr[i])
            this.arr.push(translated_arr[i])
        }
        this.ind = 0
        while (this.arr[this.arr.length - 1] === "" || this.arr[this.arr.length - 1].length < 5) {
            this.arr.pop()
        }
    }

    previous() {
        if (this.ind > 0)  {
            this.ind--
            document.getElementById("sentence").innerHTML = this.arr[this.ind]
        }
        if (this.ind === this.arr.length - 2) {
            document.getElementById("last-sentence").style.display = "none"

        }
    }

    next() {
        if (this.ind < this.arr.length - 1)  {
            this.ind++
            document.getElementById("sentence").innerHTML = this.arr[this.ind]
        } else {
            document.getElementById("last-sentence").style.display = "block"
        }
    }

    get name() {
        return this.nameTarget.value
    }
}
