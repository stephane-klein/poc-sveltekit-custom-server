<script>
    import { version, dev } from '$app/environment';

    let { data } = $props();
</script>

<p>SvelteKit version: {version}</p>

<p>Environment: {dev? 'dev' : 'prod'}</p>

<table>
    <tbody>
        {#each data.posts as row (row.id)}
            <tr>
                <td>{row.id}</td>
                <td>{row.title}</td>
            </tr>
        {/each}
    </tbody>
</table>
