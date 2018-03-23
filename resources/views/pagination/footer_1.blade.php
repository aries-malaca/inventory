<button v-bind:disabled="pagination[1].current_page==1" class="btn btn-sm"
@click="setPage(pagination[1].current_page - 1,1)">
Previous
</button>
<button v-bind:disabled="pagination[0].current_page==Math.ceil(pagination[1].original_length/pagination[1].per_page) || pagination[1].original_length==0"
@click="setPage(pagination[1].current_page + 1,1)" class="btn btn-sm">
Next
</button><br/><br/>
<span v-text=" 'Showing ' + pagination[1].current_page + ' Page of ' + Math.ceil(pagination[1].original_length/pagination[1].per_page) + ' of ' + pagination[1].original_length + ' entries'"></span>
