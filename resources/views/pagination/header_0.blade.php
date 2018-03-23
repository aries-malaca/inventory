<label> Show:
    <select v-model="pagination[0].per_page" @change="pagination[0].current_page=1" class="form-control">
    <option v-bind:value="5">5</option>
    <option v-bind:value="10">10</option>
    <option v-bind:value="20">20</option>
    <option v-bind:value="10000">All</option>
    </select>
</label>
<label> Search:
    <input type="search" v-model="pagination[0].search" class="form-control">
</label>