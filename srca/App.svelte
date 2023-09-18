
<script>

  import { invoke } from '@tauri-apps/api/tauri'

  let appname = ''
  let url = ''
  let infoMessage = ''

  async function create_app() {
    infoMessage = "Building..."
    let a = await invoke('create_app', { appname,url })
    infoMessage = await a;
  }


</script>



<html>
  <body>

    <h1 style="color: white">
      Rebirth
    </h1>
    <div class="inputs">
      <label>
        App name:
      </label>
      <input type="text" bind:value={appname}>

      <label>
        Url:
      </label>
      <input type="text" bind:value={url}>
      <br>

    <button on:click={create_app}>Create app</button>
      <br>
      <br>
      <textarea disabled="true" rows="1">{infoMessage}</textarea>


    </div>

  </body>

</html>

<style>

  body{
    display: grid;
    align-items: center;
    justify-items: center;
    justify-content: center;
    grid-row-gap: 20px;
  }

  label{
    color: white;
  }

  .inputs{
    display: grid;
    justify-content: center;
  }

  h1{
    margin-top: 100px;
    grid-column: 1;
    grid-row: 1;
  }

  textarea{
    text-align: center;
    color: green;
  }


</style>