import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["name"]
    static arr = []
    static ind

    connect() {
        let article = this.name
        this.arr = article.match(/[^\.!\?]+[\.!\?]+["']?|\s*$/g)
        this.ind = 0
        if (this.arr[this.arr.length - 1] === "") {
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
