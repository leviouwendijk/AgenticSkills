import Agentic
import AgenticIO

public extension CoreSkillProvider {
    static let safeFileEditing = AgentSkill(
        identifier: "safe-file-editing",
        name: "Safe file editing",
        summary: "Read before writing, edit the smallest safe range, and report concrete file changes.",
        body: """
        Use a conservative file-editing workflow.

        Workflow:
        1. Inspect the target source before mutating it.
        2. When the target file is not yet known, use `\(FindPathsTool.identifier.rawValue)` and `\(SearchSourcesTool.identifier.rawValue)` to narrow the mutation target before loading source text.
        3. Use `\(LoadSearchContextTool.identifier.rawValue)` to inspect search-discovered candidate ranges before editing them.
        4. Use `\(ReadFileTool.identifier.rawValue)` for the smallest useful line range when the exact file is already known.
        5. Use `\(ScanPathsTool.identifier.rawValue)` only when filesystem topology or exhaustive path discovery is required.
        6. Use `\(MutateFilesTool.identifier.rawValue)` with edit_text for targeted line operations.
        7. Use replace_text in the same tool only when replacing an entire file is clearer and safer than line edits.
        8. Keep edits contiguous and reviewable.
        9. Preserve existing style, naming, imports, formatting, comments, and public API shape unless the task explicitly requires changing them.
        10. After mutation, summarize touched paths, edit type, and changed line ranges or diff summary when available.

        Safety rules:
        - Never mutate a file you have not inspected unless the user explicitly asked for a blind write.
        - Never combine unrelated changes in the same edit.
        - Never widen a requested change into cleanup unless the cleanup is required for correctness.
        - Prefer additions or replacements with clear boundaries over broad rewrites.
        - Stop and explain if the available tools cannot make the change safely.
        """,
        metadata: .init(
            domains: [
                .core
            ],
            tools: .init(
                required: [
                    .tool(ReadFileTool.identifier),
                    .tool(MutateFilesTool.identifier)
                ],
                optional: [
                    .tool(FindPathsTool.identifier),
                    .tool(SearchSourcesTool.identifier),
                    .tool(LoadSearchContextTool.identifier),
                    .tool(ScanPathsTool.identifier)
                ]
            ),
            tags: [
                "core",
                "files",
                "editing",
                "safety"
            ],
            attributes: [
                "pack": "base",
                "kind": "workflow"
            ]
        )
    )
}
